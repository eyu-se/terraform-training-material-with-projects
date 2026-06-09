resource "aws_s3_bucket" "versioned" {
  bucket = "tf-example-versioned-bucket"
}

resource "aws_s3_bucket_versioning" "versioned" {
  bucket = aws_s3_bucket.versioned.id

  versioning_configuration {
    status = "Enabled"
  }
}

resource "aws_s3_bucket_server_side_encryption_configuration" "versioned" {
  bucket = aws_s3_bucket.versioned.id

  rule {
    apply_server_side_encryption_by_default {
      sse_algorithm = "AES256"
    }
  }
}
