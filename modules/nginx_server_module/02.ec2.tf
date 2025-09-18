
resource "aws_instance" "nginx_server" {

    ami = var.ami_id
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