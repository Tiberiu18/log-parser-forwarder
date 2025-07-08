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
variable "user_data_path" {
  description = "The user_data script path"
  default     = ""
  type        = string

}


variable "public_subnet_cidr_block" {
  description = "Public subnet CIDR block"
  type        = string
  default     = "10.0.1.0/24"
}

variable "vpc_cidr_block" {
  description = "VPC CIDR block"
  type        = string
  default     = "10.0.0.0/16"
}




