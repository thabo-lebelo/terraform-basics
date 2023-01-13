provider "aws" {
  region = "af-south-1"
}

resource "aws_instance" "myec2" {
  ami             = "ami-020ae3a2e1e9ac55b"
  instance_type   = "t3.micro"
  security_groups = [aws_security_group.webtraffic.name]
}

resource "aws_security_group" "webtraffic" {
  name = "Allow HTTPS"

  ingress = [{
    cidr_blocks = ["0.0.0.0/0"]
    from_port   = 443
    protocol    = "TCP"
    to_port     = 443
    security_groups = []
    ipv6_cidr_blocks =[]
    prefix_list_ids = []
    description = ""
    self = false
  }]

  egress = [{
    cidr_blocks = ["0.0.0.0/0"]
    from_port   = 443
    protocol    = "TCP"
    to_port     = 443
    security_groups = []
    ipv6_cidr_blocks =[]
    prefix_list_ids = []
    description = ""
    self = false
  }]

}
