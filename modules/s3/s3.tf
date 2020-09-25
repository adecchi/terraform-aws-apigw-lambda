resource "aws_s3_bucket" "applications_bucket" {
  bucket = var.bucket_name
  acl    = "private"
}

resource "aws_s3_bucket_object" "file_upload" {
  bucket     = var.bucket_name
  key        = var.key
  source     = var.source_path
  depends_on = [aws_s3_bucket.applications_bucket]
}
