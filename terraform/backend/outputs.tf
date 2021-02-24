output "loadbalancer_url" {
    value = aws_elb.backend.dns_name
}

output "database_url" {
    value = aws_db_instance.backend.address
}