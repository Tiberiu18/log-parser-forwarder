variable "region" {
  description = "Region"
  default     = "eu-central-1"

}

variable "profile" {
  description = "AWS Credentials Profile"
  default     = "default"

}

variable "tags" {
  description = "Tag mapping"
  type        = map(string)
  default = {
    Environment = "DEV"
  }

}
