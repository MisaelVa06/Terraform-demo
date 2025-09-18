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