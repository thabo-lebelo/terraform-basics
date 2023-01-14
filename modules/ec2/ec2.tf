variable "ec2name" {
  type = string
}

resource "aws_instance" "myec2" {
  ami           = "ami-020ae3a2e1e9ac55b"
  instance_type = "t3.micro"
  tags = {
    Name = var.ec2name
  }
}

output "instance_id" {
  value = aws_instance.myec2.id
}
