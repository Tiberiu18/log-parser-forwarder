
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


# S3 Module Outputs
output "bucket_name" {
  description = "Bucket name that's been created"
  value       = module.s3.bucket_name

}

output "bucket_arn" {
  description = "Bucket ARN"
  value       = module.s3.bucket_arn

}

output "bucket_region" {
  description = "Bucket region"
  value       = module.s3.bucket_region

}

output "bucket_tags" {
  description = "Tag-urile bucketului"
  value       = module.s3.bucket_tags
}

output "website_endpoint" {
  description = "HTTP URL of static website"
  value       = module.s3.website_endpoint

}

output "rest_endpoint" {
  description = "REST URL (https) for objects"
  value       = module.s3.rest_endpoint

}

