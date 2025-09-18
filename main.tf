provider "aws"{
    region = "us-east-1"
}


resource "aws_instance" "nginx_server" {

    ami = "ami-08982f1c5bf93d976"
    instance_type ="m7i-flex.large"

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
}

    ###KEY PAIR

resource "aws_key_pair" "nginx_server_ssh"{

    key_name = "nginx_server_ssh"
    public_key = file("nginx-server.key.pub")

}


   ###SECURITY GROUPS
resource "aws_security_group" "nginx_server_SG"{

    name= "nginx_server_SG"
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

output "Server_public_IP" {
  value       = aws_instance.nginx_server.public_ip
}

output "Server_public_DNS" {
  value       = aws_instance.nginx_server.public_dns
}