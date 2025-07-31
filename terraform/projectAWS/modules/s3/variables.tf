variable "region" {
  description = "Region"
  default     = "eu-central-1"

}


variable "bucket_name" {
  type = string
}

variable "versioning_status" {
  type    = string
  default = "Suspended"
}

variable "s3_object_ownership" {
  type    = string
  default = "BucketOwnerEnforced"
}

variable "enable_public_access" {
  type    = bool
  default = false
}

variable "index_document" {
  type    = string
  default = "index.html"
}

variable "enable_website" {
  type    = bool
  default = false
}

variable "error_document" {
  type    = string
  default = "error.html"
}

variable "tags" {
  description = "Tag mapping"
  type        = map(string)

}
