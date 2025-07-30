provider "aws" {
  region  = var.region
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
  instance_type      = var.instance_type
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

module "s3" {
  source               = "./modules/s3"
  for_each             = toset(var.bucket_names)
  bucket_name          = each.key
  tags                 = var.tags
  versioning_status    = var.versioning_status
  s3_object_ownership  = var.s3_object_ownership
  enable_public_access = var.enable_public_access
  enable_website       = var.enable_website
  index_document       = var.index_document
  error_document       = var.error_document

}
