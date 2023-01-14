resource "aws_instance" "web" {
  ami             = "ami-020ae3a2e1e9ac55b"
  instance_type   = "t3.micro"
  security_groups = [module.sg.sg_name]
  user_data       = file("./web/server-script.sh")
  tags = {
    Name = "Web Server"
  }
}

output "PublicIP" {
  value = module.eip.public_ip
}

module "eip" {
  source = "../eip"
  instance_id = aws_instance.web.id
}

module "sg" {
  source = "../sg"
}
