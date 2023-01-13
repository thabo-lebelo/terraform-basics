provider "aws" {
  region = "af-south-1"
}

variable "vpcname" {
  type    = string
  default = "myvpc"
}

variable "sshport" {
  type    = number
  default = 22
}

variable "enabled" {
  default = true
}

variable "mylist" {
  type    = list(string)
  default = ["Value1", "Value2"]
}

variable "mymap" {
  type = map(any)
  default = {
    Key1 = "Value1"
    Key2 = "Value2"
  }
}

variable "inputname" {
  type        = string
  description = "Set the name of the VPC"
}

variable "mytuple" {
  type    = tuple([string, number, string])
  default = ["value1", 2, " value3"]
}

variable "myobject" {
  type = object({ name = string, port = list(number) })
  default = {
    name = "Thabo"
    port = [22, 80, 443]
  }
}

resource "aws_vpc" "myvpc" {
  cidr_block = "10.0.0.0/16"

  tags = {
    Name = var.inputname
  }
}

output "vpcid" {
  value = aws_vpc.myvpc.id
}
