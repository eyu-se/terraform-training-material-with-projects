resource "aws_s3_bucket" "deps" {
  bucket = "deps-bucket"
}

# Implicit dependency via reference
resource "aws_s3_bucket_versioning" "deps" {
  bucket = aws_s3_bucket.deps.id
  versioning_configuration {
    status = "Enabled"
  }
}

# Implicit dependency via reference
resource "aws_s3_bucket_public_access_block" "deps" {
  bucket = aws_s3_bucket.deps.id

  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true
}

# Explicit dependency — no reference to bucket, but must be created after
resource "aws_sqs_queue" "deps" {
  name = "deps-queue"

  depends_on = [aws_s3_bucket.deps]
}

# Chained dependency — depends on both bucket and queue
resource "aws_dynamodb_table" "deps" {
  name         = "deps-table"
  billing_mode = "PAY_PER_REQUEST"
  hash_key     = "pk"

  attribute {
    name = "pk"
    type = "S"
  }

  tags = {
    QueueArn = aws_sqs_queue.deps.arn
  }

  depends_on = [
    aws_s3_bucket.deps,
    aws_sqs_queue.deps,
  ]
}
