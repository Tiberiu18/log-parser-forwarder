provider "aws" {
  region  = var.region
  profile = var.profile
}

module "ssh_key" {
  source          = "./modules/ssh_key"
  key_name        = var.key_name
  public_key_path = var.public_key_path

}

module "vpc" {
  source               = "./modules/vpc"
  vpc_cidr             = var.vpc_cidr
  public_subnet_cidrs  = var.public_subnet_cidrs
  private_subnet_cidrs = var.private_subnet_cidrs
  availability_zone    = var.availability_zone
  tags                 = var.tags
}

module "ec2" {
  source             = "./modules/ec2"
  ami_id             = var.ami_id
  instance_type      = var.instance_type
  key_name           = var.key_name
  availability_zone  = var.availability_zone
  public_subnet_id   = module.vpc.public_subnet_id
  security_group_ids = [module.vpc.security_group_id]
  user_data_path     = file(var.user_data_path)
  tags               = var.tags


}

module "ebs" {
  source            = "./modules/ebs"
  availability_zone = var.availability_zone
  size              = var.size
  type              = var.type
  encrypted         = var.encrypted
  device_name       = var.device_name
  instance_id       = module.ec2.instance_id

}


