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
