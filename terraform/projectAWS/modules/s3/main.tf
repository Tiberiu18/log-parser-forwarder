resource "aws_s3_bucket" "my_bucket" {
  bucket = var.bucket_name
  tags   = var.tags

}
resource "aws_s3_bucket_versioning" "versioning" {
  bucket = aws_s3_bucket.my_bucket.id
  versioning_configuration {
    status = var.versioning_status
  }

}

resource "aws_s3_bucket_ownership_controls" "custom_ownership" {
bucket = aws_s3_bucket.my_bucket.id
rule {
	object_ownership = var.s3_object_ownership
}

}


# Public access block deactivation
resource "aws_s3_bucket_public_access_block" "pab_deactivation" {
count = var.enable_public_access ? 1 : 0
bucket = aws_s3_bucket.my_bucket.id
block_public_acls = false
ignore_public_acls = false
block_public_policy = false
restrict_public_buckets = false

}

resource "aws_s3_bucket_lifecycle_configuration" "lifecycle" {
  bucket = aws_s3_bucket.my_bucket.id

  rule {
    id     = "expire-old-objects"
    status = "Enabled"

    filter  {} # apply to every object
    expiration {
      days = 30
    }

  }
}

resource "aws_s3_bucket_policy" "public_policy" {
  bucket = aws_s3_bucket.my_bucket.id
  policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Sid       = "PublicReadGetObject"
        Effect    = "Allow",
        Principal = "*",
        Action    = "s3:GetObject",
        Resource  = "${aws_s3_bucket.my_bucket.arn}/*"
      }
    ]


  })

	depends_on = [aws_s3_bucket_public_access_block.pab_deactivation]

}

resource "aws_s3_bucket_website_configuration" "site" {
count = var.enable_website ? 1 : 0
bucket = aws_s3_bucket.my_bucket.id
index_document {
	suffix = var.index_document
}

error_document  {
	key = var.error_document
}

}

