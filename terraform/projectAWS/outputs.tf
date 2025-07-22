
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

# EC2 Module Outputs
output "instance_id" {
  value = module.ec2.instance_id

}

output "instance_public_ip" {
  value = module.ec2.instance_public_ip
}

output "ec2_login_user" {
  value = module.ec2.ec2_login_user
}

output "ec2_private_key_path" {
  value = module.ec2.ec2_private_key_path
}


# S3 Module Outputs
output "bucket_name" {
  description = "Bucket name that's been created"
  value       = [for mod in module.s3 : mod.bucket_name]

}

output "bucket_arn" {
  description = "Bucket ARN"
  value = {
    for name, mod in module.s3 :
    name => mod.bucket_arn
  }

}

output "bucket_region" {
  description = "Bucket region"
  value = {
    for name, mod in module.s3 :
    name => mod.bucket_region

  }

}

output "bucket_tags" {
  description = "Tag-urile bucketului"
  value = {
    for name, mod in module.s3 :
    name => mod.bucket_tags
  }
}

output "website_endpoint" {
  description = "HTTP URL of static website"
  value = {
    for name, mod in module.s3 :
    name => mod.website_endpoint
  }

}

output "rest_endpoint" {
  description = "REST URL (https) for objects"
  value = {
    for name, mod in module.s3 :
    name => mod.rest_endpoint

  }

}

output "ec2_login_user" {
value = module.ec2.ec2_login_user
}

