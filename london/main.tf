locals {
  region = "eu-west-2"
}

provider "aws" {
  region = local.region
}

module "vpc" {
  source = "../module/vpc"
  region = local.region
  vpc-cidr = "10.10.10.0/24"
  subnet-cidr-a = "10.10.10.0/27"
  subnet-cidr-b = "10.10.10.32/27"
  subnet-cidr-c = "10.10.10.64/27"
}

module "ec2" {
  source = "../module/ec2"
  ami-id = "ami-0ad32127d6f7eb18a"
  subnet-a-id = module.vpc.subnet-a-id
  vpc-id = module.vpc.vpc-id
}

output "domain-name" {
  value = "http://${module.ec2.nginx_domain}"
}