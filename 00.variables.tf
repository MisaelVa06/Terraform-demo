    ###Variables
   
variable "ami_id" {
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