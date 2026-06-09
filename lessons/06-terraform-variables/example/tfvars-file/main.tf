resource "aws_s3_bucket" "main" {
  bucket = "${var.project_name}-${var.environment}-data"
  tags   = var.tags
}

resource "aws_s3_bucket_versioning" "main" {
  bucket = aws_s3_bucket.main.id
  versioning_configuration {
    status = "Enabled"
  }
}

resource "aws_dynamodb_table" "main" {
  name         = "${var.project_name}-${var.environment}-table"
  billing_mode = "PAY_PER_REQUEST"
  hash_key     = "pk"

  attribute {
    name = "pk"
    type = "S"
  }

  tags = var.tags
}

resource "aws_sqs_queue" "main" {
  name = "${var.environment}-events"
  tags = var.tags
}
