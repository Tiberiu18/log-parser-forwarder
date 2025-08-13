variable "regi" {
  description = "Default region for VPC"
  type        = string
  default     = "eu-central-1"
}

variable "vpc_cidr" {
  description = "CIDR block for the VPC"
  type        = string
  default     = "10.0.0.0/16"
}

variable "public_subnet_cidrs" {
  description = "List of CIDR blocks for public subnets"
  type        = list(string)
  default     = ["10.0.1.0/24", "10.0.2.0/24"]

}

variable "private_subnet_cidrs" {
  description = "List of CIDR blocks for private subnets"
  type        = list(string)
  default     = ["10.0.3.0/24", "10.0.4.0/24"]

}


variable "tags" {
  description = "Map of tags to apply to all resources"
  type        = map(string)
  default = {
    Environment = "dev"
    Project     = "log-parser"

  }
}

variable "availability_zone" {
  type = string
}

variable "availability_zones" {
  type    = list(string)
  default = ["eu-north-1a", "eu-north-1b"]

}
