provider "aws" {
  region = "af-south-1"
}

module "ec2module" {
  source  = "./ec2"
  ec2name = "Web Server"
}

output "module_outpot" {
  value = module.ec2module.instance_id
}
