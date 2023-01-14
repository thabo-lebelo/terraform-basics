resource "aws_instance" "db" {
  ami           = "ami-020ae3a2e1e9ac55b"
  instance_type = "t3.micro"

  tags = {
    Name = "DB Server"
  }
}

output "PrivateIP" {
  value = aws_instance.db.private_ip
}
