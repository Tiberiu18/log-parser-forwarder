provider "aws" {
region = "eu-north-1"
profile = "default"
}


module "vpc" {
source = "../"
vpc_cidr = "10.0.0.0/16"
public_subnet_cidrs = ["10.0.1.0/24"]
private_subnet_cidrs = ["10.0.2.0/24"]
tags = {
Project = "test-vpc"
Environment = "test"
}



}


output "vpc_id" {
value = module.vpc.vpc_id


}

output "public_subnet_id" {
value = module.vpc.public_subnet_id

}


output "private_subnet_id" {
value = module.vpc.private_subnet_id

}

output "security_group_id" {
value = module.vpc.security_group_id

}

output "public_route_table_id" {
value = module.vpc.public_route_table_id

}

output "private_route_table_id" {
value = module.vpc.private_route_table_id

}


output "internet_gateway_id" {
value = module.vpc.internet_gateway_id

}

output "nat_gateway_id" {
value = module.vpc.nat_gateway_id
}
