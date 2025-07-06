variable "region" {
  default = "eu-north-1"
}

variable "profile" {
  description = "Profile for AWS credentials"
}

variable "instance_type" {
  default = "t3.micro"
}

variable "key_name" {
  description = "AWS key pair name"
  default     = "log-parser"
}

variable "ami_id" {
  description = "Ubuntu AMI ID"
  default     = "ami-02003f9f0fde924ea"
}

variable "tags" {
  description = "Mappings"
  type        = map(string)
}

variable "availability_zone" {
  description = "Availability zone for EC2 instance"
  type        = string

}

variable "vpc_id" {
  type = string
}

variable "public_subnet_id" {

  type = string

}

variable "security_group_ids" {
  description = "List of security group IDs to associate with the EC2 instance"
  type        = list(string)
}

variable "user_data" {
  description = "The user_data script content"
  default     = ""
  type        = string

}

