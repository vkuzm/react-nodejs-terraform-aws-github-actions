variable "instance_type" {
  description = "Instance type"
  default = "t3.micro"
}

variable "PORT_CONTAINER" {
  description = "Port contaner"
  default = ""
}

variable "DOCKER_IMAGE" {
  description = "Docker image"
  default = ""
}