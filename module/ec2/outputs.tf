output "nginx_domain" {
  value = aws_instance.instance.public_dns
}