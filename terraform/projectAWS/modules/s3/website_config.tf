resource "aws_s3_bucket_website_configuration" "site" {
bucket = aws_s3_bucket.my_bucket.id
index_document {
	suffix = "index.html"
}

error_document  {
	key = "404.html"
}

}
