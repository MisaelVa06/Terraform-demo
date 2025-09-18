###Modulos###

module "nginx_server_dev" {
  source = "./modules/nginx_server_module"

  ami_id = "ami-08982f1c5bf93d976"
  instance_type = "t3.micro"
  server_name = "nginx_server_dev"
  enviroment = "Prod"
  Owner = "Misal"
    
}

output "nginx_server_dev" {
  description = "Datos del servidor desplegado"
  value       = module.nginx_server_dev.server
}