provider "aws" {
  region = "af-south-1"
}

provider "aws" {
  region = "eu-west-1"
  alias = "Ireland"
}

resource "aws_vpc" "cptvpc" {
  cidr_block = "10.0.0.0/16"
}

resource "aws_vpc" "irlvpc" {
  cidr_block = "10.0.0.0/16"
  provider = aws.Ireland
}
