provider "aws" {
	region = "eu-central-1"

}

module "vpc" {
	source = "../vpc"

}
