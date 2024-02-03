locals {
  region = "us-east-1"
}

provider "aws" {
  region = local.region
}

module "vpc" {
  source = "../module/vpc"
  region = local.region
  vpc-cidr = "10.10.11.0/24"
  subnet-cidr-a = "10.10.11.0/27"
  subnet-cidr-b = "10.10.11.32/27"
  subnet-cidr-c = "10.10.11.64/27"
}

module "ec2" {
  source = "../module/ec2"
  ami-id = "ami-0277155c3f0ab2930"
  subnet-a-id = module.vpc.subnet-a-id
  vpc-id = module.vpc.vpc-id
}

output "domain-name" {
  value = "http://${module.ec2.nginx_domain}"
}