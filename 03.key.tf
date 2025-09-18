    ###KEY PAIR

resource "aws_key_pair" "nginx_server_ssh"{

    key_name = "${var.server_name}_ssh"
    public_key = file("nginx-server.key.pub")

}
