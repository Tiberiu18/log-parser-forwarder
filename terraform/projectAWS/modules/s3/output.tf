output "bucket_name" {
  description = "Bucket name that's been created"
  value       = aws_s3_bucket.my_bucket.bucket

}

output "bucket_arn" {
  description = "Bucket ARN"
  value       = aws_s3_bucket.my_bucket.arn

}

output "bucket_region" {
  description = "Bucket region"
  value       = aws_s3_bucket.my_bucket.region

}

output "bucket_tags" {
  description = "Tag-urile bucketului"
  value       = aws_s3_bucket.my_bucket.tags
}

output "website_endpoint" {
description = "HTTP URL of static website"
	value = aws_s3_bucket_website_configuration.site.website_endpoint

}

output "rest_endpoint" {
description = "REST URL (https) for objects"
value = aws_s3_bucket.my_bucket.bucket_domain_name

}
