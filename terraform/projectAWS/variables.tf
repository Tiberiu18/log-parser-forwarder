# Provider-related
variable "region" {
  type        = string
  description = "AWS region"
}

variable "profile" {
  type        = string
  description = "AWS CLI profile"
}

# SSH key module
variable "public_key_path" {}
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
variable "ami_id" {
  type        = string
  description = "AMI ID for the EC2 instance"
}

variable "instance_type" {
  type        = string
  description = "EC2 instance type"
}

variable "key_name" {
  type        = string
  description = "Name of the SSH key pair"
}

variable "availability_zone" {
  type        = string
  description = "Availability Zone for EC2 and EBS"
}

variable "user_data_path" {
  type        = string
  default = ""
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
# Common
variable "tags" {
  type        = map(string)
  description = "Tags to apply to all resources"
}

