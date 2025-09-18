 ###OUTPUTS

output "server" {
  description = "Datos del servidor desplegado"
  value = {
    name      = var.server_name
    public_ip = aws_instance.nginx_server.public_ip
    public_dns = aws_instance.nginx_server.public_dns
    id        = aws_instance.nginx_server.id
  }
}