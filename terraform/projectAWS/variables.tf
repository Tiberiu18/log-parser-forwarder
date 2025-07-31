# Provider-related
variable "region" {
  type        = string
  description = "AWS region"
}


# VPC Module
variable "vpc_cidr" {
  type        = string
  description = "CIDR block for the VPC"
}

variable "public_subnet_cidrs" {
  type        = list(string)
  description = "List of CIDRs for public subnets"
}

variable "private_subnet_cidrs" {
  type        = list(string)
  description = "List of CIDRs for private subnets"
}

# EC2 Module

variable "instance_type" {
  type        = string
  description = "EC2 instance type"
}


variable "availability_zone" {
  type        = string
  description = "Availability Zone for EC2 and EBS"
}

variable "user_data_path" {
  type        = string
  default     = ""
  description = "User data script content or file path"
}

# EBS Module
variable "size" {
  type        = number
  description = "Size of the EBS volume in GiB"
}

variable "type" {
  type        = string
  description = "Type of the EBS volume (gp3, gp2, etc.)"
}

variable "encrypted" {
  type        = bool
  description = "Whether the EBS volume should be encrypted"
}

variable "device_name" {
  type        = string
  description = "Device name to attach the EBS volume as (e.g. /dev/sdf)"
}


# S3 Module
#variable "bucket_name" {
# type        = string
#description = "Bucket name that will be created"
#}

variable "bucket_names" {
  type        = list(string)
  description = "List of bucket names that will be created"

}

variable "versioning_status" {
  type        = string
  description = "Versioning status of the bucket i.e. Enabled, Disabled, Suspended"
}

variable "s3_object_ownership" {
  type        = string
  description = "Type of object ownership for the S3 Bucket"
}

variable "enable_public_access" {
  type        = bool
  description = "Whether or not to enable public access to the S3 Bucket"
}

variable "enable_website" {
  type        = bool
  description = "Whether or not to enable website or not for the S3 Bucket"
}

variable "index_document" {
  type        = string
  description = "Path to the index document of the S3 Bucket static site"
}

variable "error_document" {
  type        = string
  description = "Path to the error document of the S3 Bucket static site"
}

# Common
variable "tags" {
  type        = map(string)
  description = "Tags to apply to all resources"
}

