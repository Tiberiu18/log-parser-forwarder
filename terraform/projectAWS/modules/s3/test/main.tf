provider "aws" {
  region = "eu-north-1"
}

module "s3" {
  source               = "../"
  bucket_name          = "tibi-bucket-07072025"
  tags                 = { Environment = "test" }
  versioning_status    = "Disabled"
  s3_object_ownership  = "BucketOwnerPreferred"
  enable_public_access = true
  enable_website       = true
  index_document       = "index.html"
  error_document       = "error.html"


}
