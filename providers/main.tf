provider "aws" {
  region = "af-south-1"
}

provider "vault" {
  
}

resource "vault_generic_secret" "mypassword" {
  
}

resource "aws_vpc" "myvpc" {
  cidr_block = "10.0.0.0/16"
}
