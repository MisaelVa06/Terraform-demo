    ###Variables
   
variable "aim_id" {
  default     = "ami-08982f1c5bf93d976"
  description = "ID de AMI para instancia EC2"
}

variable "instance_type" {
  default     = "m7i-flex.large"
  description = "Tipo de instancia EC2"
}

variable "server_name" {
  default     = "nginx_server"
  description = "Nombre de la instancia EC2"
}

variable "enviroment" {
  default     = "test"
  description = "ambiente de la aplicacion"
}

variable "region" {
  default     = "us-east-1"
  description = "region de la instancia"
}

variable "Owner" {
  default     = "Misael Vasquez"
  description = "Owner de la instancia"
}


provider "aws"{
    region = var.region
}


resource "aws_instance" "nginx_server" {

    ami = var.aim_id
    instance_type = var.instance_type

    user_data = <<-EOF
		#!/bin/bash
		sudo yum install -y nginx
		sudo systemctl enable nginx
		sudo systemctl start nginx
		EOF

    ##SSH-KEY ASSIGNATION
    key_name = aws_key_pair.nginx_server_ssh.key_name

    ##VPC_SECURITY GROUP
    vpc_security_group_ids = [
        aws_security_group.nginx_server_SG.id
    ]

    ###TAGS
    tags = {
        Name = var.server_name
        enviroment = var.enviroment
        Owner = var.Owner
    }


}

    ###KEY PAIR

resource "aws_key_pair" "nginx_server_ssh"{

    key_name = "${var.server_name}_ssh"
    public_key = file("nginx-server.key.pub")

}


   ###SECURITY GROUPS
resource "aws_security_group" "nginx_server_SG"{

    name= "${var.server_name}_SG"
    description = "Security group for only port 22 and 80 available"

    ingress{

      from_port = 22
	  to_port = 22
	  protocol = "tcp"
	  cidr_blocks = ["0.0.0.0/0"]
    }

    ingress{

      from_port = 80
	  to_port = 80
	  protocol = "tcp"
	  cidr_blocks = ["0.0.0.0/0"]
    }

    egress{
        from_port = 0
        to_port = 0
        protocol = "-1"
        cidr_blocks = ["0.0.0.0/0"]
    }

}

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