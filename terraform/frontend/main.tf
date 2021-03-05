terraform {
  backend "s3" {
  }
}

provider "aws" {}

resource "aws_security_group" "frontend" {
  name = "security-group-frontend-apps"

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "frontend"
  }
}

resource "aws_instance" "frontend" {
    count = 1

    ami                         = data.aws_ami.latest_amazon_linux.id
    instance_type               = var.instance_type
    vpc_security_group_ids      = [aws_security_group.frontend.id]
    availability_zone           = data.aws_availability_zones.available.names[0]
    associate_public_ip_address = "true"
    user_data                   = templatefile("deployment.sh.tpl", {
      PORT_EXTERNAL  = "80"
      PORT_CONTAINER = var.PORT_CONTAINER
      DOCKER_IMAGE   = var.DOCKER_IMAGE
      API_URL        = data.aws_elb.backend-app-elb.dns_name
    })

    tags = {
      Name = "frontend"
    }

    lifecycle {
        create_before_destroy = true
    }
}