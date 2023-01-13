provider "aws" {
  region = "af-south-1"
}

variable "ingressrules" {
  type    = list(number)
  default = [80, 443]
}

variable "egressrules" {
  type    = list(number)
  default = [80, 443, 25, 3306, 53, 8080]
}

resource "aws_instance" "myec2" {
  ami             = "ami-020ae3a2e1e9ac55b"
  instance_type   = "t3.micro"
  security_groups = [aws_security_group.webtraffic.name]
}

resource "aws_security_group" "webtraffic" {
  name = "Allow HTTPS"

  dynamic "ingress" {
    iterator = port
    for_each = var.ingressrules
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
    for_each = var.egressrules
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
