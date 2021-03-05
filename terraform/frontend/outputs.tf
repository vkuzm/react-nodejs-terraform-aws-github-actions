output "server public dns" {
    value = aws_instance.frontend.public_dns
}

output "docker_image" {
    value = var.DOCKER_IMAGE
}

output "port_container" {
    value = var.PORT_CONTAINER
}