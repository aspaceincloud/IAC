# configure aws provider

provider "aws" {
    region = var.region
}


terraform {
  backend "s3" {
    bucket = "abhiterrastatefile"
    key = "remotestate/terraform.tfstate"
    region = "us-east-1"
    dynamodb_table = "dynamo-state-locking-for-statefile"
  }
}

module "aws_vpc" {
    source = "../../modules/network/vpc"
    region = var.region
    project_name = var.project_name
    vpc_cidr = var.vpc_cidr
    public_subnet_a_cidr = var.public_subnet_a_cidr
    public_subnet_b_cidr = var.public_subnet_b_cidr
    private_subnet_a_cidr = var.private_subnet_a_cidr
    private_subnet_b_cidr = var.private_subnet_b_cidr
}

# create nat gateway
module "nat_gateway" {
    source = "../../modules/network/nat-gateway"
    public_subnet_a_id = module.aws_vpc.public_subnet_a_id
    internet_gateway = module.aws_vpc.internet_gateway
    public_subnet_b_id = module.aws_vpc.public_subnet_b_id
    vpc_id = module.aws_vpc.vpc_id
    private_subnet_a_id = module.aws_vpc.private_subnet_a_id
    private_subnet_b_id = module.aws_vpc.private_subnet_b_id
}

# create security groups
module "security_group" {
  source = "../../modules/network/security-groups"
  vpc_id = module.aws_vpc.vpc_id
}

# create ec2 instances

module "ec2" {
  source = "../../modules/compute/ec2"
  ami= var.ami
  instance_type = var.instance_type
  ssh_security_group_id = module.security_group.ssh_security_group_id
  private_subnet_a_id = module.aws_vpc.private_subnet_a_id
  private_subnet_b_id = module.aws_vpc.private_subnet_b_id
  web_vm_attribute = var.web_vm_attribute
  pri_vm_attribute = var.pri_vm_attribute
  public_subnet_a_id = module.aws_vpc.public_subnet_a_id
  public_subnet_b_id = module.aws_vpc.public_subnet_b_id
}