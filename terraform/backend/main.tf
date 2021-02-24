terraform {
  backend "s3" {
  }
}

provider "aws" {}

resource "aws_security_group" "backend" {
  name = "security-group-backend-apps"

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 5432
    to_port     = 5432
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
    Name = "backend"
  }
}

resource "aws_elb" "backend" {
    name               = "backend-app-elb"
    availability_zones = [
        data.aws_availability_zones.available.names[0], 
        data.aws_availability_zones.available.names[1]
    ]
    security_groups = [aws_security_group.backend.id]
    instances       = aws_instance.backend.*.id

    listener {
        lb_port           = 80
        lb_protocol       = "http"
        instance_port     = 80
        instance_protocol = "http"
    }

    health_check {
        healthy_threshold    = 2
        unhealthy_threshold  = 2
        timeout              = 3
        target               = "HTTP:80/"
        interval             = 10
    }

    tags = {
        Name = "backend"
    }
}

resource "aws_default_subnet" "default_az1" {
    availability_zone = data.aws_availability_zones.available.names[0]
}

resource "aws_default_subnet" "default_az2" {
    availability_zone = data.aws_availability_zones.available.names[1]
}

resource "aws_instance" "backend" {
    count = 1

    ami                    = data.aws_ami.latest_amazon_linux.id
    instance_type          = var.instance_type
    vpc_security_group_ids = [aws_security_group.backend.id]
    user_data              = templatefile("deployment.sh.tpl", {
      PORT_EXTERNAL  = "80"
      PORT_CONTAINER = var.PORT_CONTAINER
      DOCKER_IMAGE = var.DOCKER_IMAGE
      PG_USER = aws_db_instance.backend.username
      PG_HOST = aws_db_instance.backend.address
      PG_DATABASE = aws_db_instance.backend.username
      PG_PASSWORD = aws_db_instance.backend.password
      PG_PORT = aws_db_instance.backend.port
    })

    tags = {
      Name = "backend"
    }

    lifecycle {
        create_before_destroy = true
    }
}

resource "aws_db_instance" "backend" {
  identifier             = "backend-database"
  allocated_storage      = 10
  engine                 = "postgres"
  engine_version         = "11.4"
  instance_class         = "db.t2.micro"
  username               = "postgres"
  password               = "postgres5464665"
  port                   = "5432"
  skip_final_snapshot    = true
  vpc_security_group_ids = [aws_security_group.backend.id]
  publicly_accessible = false
}