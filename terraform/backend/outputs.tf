output "loadbalancer_url" {
    value = aws_elb.backend.dns_name
}

output "database_url" {
    value = aws_db_instance.backend.address
}

output "docker_image" {
    value = var.DOCKER_IMAGE
}

output "port_container" {
    value = var.PORT_CONTAINER
}