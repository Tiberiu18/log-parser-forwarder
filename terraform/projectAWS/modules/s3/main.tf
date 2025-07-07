resource "aws_s3_bucket" "my_bucket" {
  bucket = "tibi-bucket-29062025"
  tags   = merge(var.tags, { Owner = "TibiPC" })

}
resource "aws_s3_bucket_versioning" "versioning" {
  bucket = aws_s3_bucket.my_bucket.id
  versioning_configuration {
    status = "Enabled"

  }

}

resource "aws_s3_bucket_ownership_controls" "custom_ownership" {
bucket = aws_s3_bucket.my_bucket.id
rule {
	object_ownership = "BucketOwnerPreferred"
}

}


# Public access block deactivation
resource "aws_s3_bucket_public_access_block" "pab_deactivation" {
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

}

