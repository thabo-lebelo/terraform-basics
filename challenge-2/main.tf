provider "aws" {
  region = "af-south-1"
}

resource "aws_instance" "db" {
  ami           = "ami-020ae3a2e1e9ac55b"
  instance_type = "t3.micro"

  tags = {
    Name = "DB Server"
  }
}

resource "aws_instance" "web" {
  ami             = "ami-020ae3a2e1e9ac55b"
  instance_type   = "t3.micro"
  security_groups = [aws_security_group.web_traffic.name]
  user_data       = file("server-script.sh")
  tags = {
    Name = "Web Server"
  }
}

resource "aws_eip" "web_ip" {
  instance = aws_instance.web.id
}

variable "ingress" {
  type    = list(number)
  default = [80, 443]
}

variable "egress" {
  type    = list(number)
  default = [80, 443]
}

resource "aws_security_group" "web_traffic" {
  name = "Allow Web Traffic"

  dynamic "ingress" {
    iterator = port
    for_each = var.ingress
    content {
      cidr_blocks      = ["0.0.0.0/0"]
      from_port        = port.value
      protocol         = "TCP"
      to_port          = port.value
      security_groups  = []
      ipv6_cidr_blocks = []
      prefix_list_ids  = []
      description      = ""
      self             = false
    }
  }

  dynamic "egress" {
    iterator = port
    for_each = var.egress
    content {
      cidr_blocks      = ["0.0.0.0/0"]
      from_port        = port.value
      protocol         = "TCP"
      to_port          = port.value
      security_groups  = []
      ipv6_cidr_blocks = []
      prefix_list_ids  = []
      description      = ""
      self             = false
    }
  }
}

output "PrivateIP" {
  value = aws_instance.db.private_ip
}

output "PublicIP" {
  value = aws_eip.web_ip.public_ip
}
