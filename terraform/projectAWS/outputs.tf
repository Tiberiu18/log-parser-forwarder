
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

output "instance_id" {
  value = module.ec2.instance_id

}

output "instance_public_ip" {
value = module.ec2.instance_public_ip

}
