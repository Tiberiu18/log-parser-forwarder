region="eu-north-1"
profile="default"
availability_zone="eu-north-1a"
vpc_cidr = "10.0.0.0/16"
public_subnet_cidrs = ["10.0.1.0/24"]
private_subnet_cidrs = ["10.0.2.0/24"]
instance_type = "t3.micro"
key_name = "test-key"
public_key_path = "~/.ssh/id_rsa.pub"
size = 2
type="gp3"
encrypted=false
device_name="/dev/xvdf"
user_data_path="scripts/user_data.sh"
tags = {
	Owner = "Tibi-DEV"
	Project = "log-parser-forward"
	Environment = "DEV"
}

# S3 Bucket variables
#bucket_name="tibi-bucket-07072025"
bucket_names = ["standard-logs-bucket",
"parsed-logs-bucket"]
versioning_status="Disabled"
s3_object_ownership="BucketOwnerPreferred"
enable_public_access=true
enable_website=true
index_document="index.html"
error_document="404.html"
