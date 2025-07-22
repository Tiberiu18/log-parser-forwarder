variable "availability_zone" {
  type = string
}

variable "size" {
  type    = number
  default = 3
}

variable "type" {
  type    = string
  default = "gp3"
}

variable "encrypted" {
  type    = bool
  default = false
}

variable "device_name" {
  type    = string
  default = "/dev/xvdf"

}

variable "instance_id" {
  type = string

}
