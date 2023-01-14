variable "ingress" {
  type    = list(number)
  default = [80, 443]
}

variable "egress" {
  type    = list(number)
  default = [80, 443]
}

output "sg_name" {
  value = aws_security_group.web_traffic.name
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
