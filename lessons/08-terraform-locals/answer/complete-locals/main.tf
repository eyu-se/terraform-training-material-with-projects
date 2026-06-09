resource "aws_s3_bucket" "main" {
  bucket = "${local.name_prefix}-data"
  tags   = local.all_tags
}

resource "aws_s3_bucket_versioning" "main" {
  count  = local.enable_versioning ? 1 : 0
  bucket = aws_s3_bucket.main.id

  versioning_configuration {
    status = "Enabled"
  }
}

resource "aws_dynamodb_table" "main" {
  name         = "${local.name_prefix}-table"
  billing_mode = "PAY_PER_REQUEST"
  hash_key     = "pk"

  attribute {
    name = "pk"
    type = "S"
  }

  tags = local.all_tags
}

resource "aws_sqs_queue" "main" {
  name                      = "${local.name_prefix}-queue"
  message_retention_seconds = local.retention_days * 86400
  tags                      = local.all_tags
}
