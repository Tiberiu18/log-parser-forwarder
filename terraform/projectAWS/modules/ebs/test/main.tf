provider "aws" {
region = var.region
}

module "ebs" {
source = "../"
availability_zone = var.availability_zone
size = var.size
type = var.type
encrypted = var.encrypted
device_name = var.device_name
instance_id = var.instance_id

}

