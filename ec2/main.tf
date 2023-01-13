provider "aws" {
  region = "af-south-1"
}

resource "aws_instance" "myec2" {
  ami           = "ami-020ae3a2e1e9ac55b"
  instance_type = "t3.micro"
}

resource "aws_eip" "elasticip" {
  instance = aws_instance.myec2.id
}

output "EIP" {
  value = aws_eip.elasticip.public_ip
}
