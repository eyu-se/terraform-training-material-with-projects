resource "aws_s3_bucket" "main" {
  bucket = "${local.name_prefix}-data"
  tags   = local.common_tags
}

resource "aws_s3_bucket_versioning" "main" {
  count  = local.enable_versioning ? 1 : 0
  bucket = aws_s3_bucket.main.id

  versioning_configuration {
    status = "Enabled"
  }
}

resource "aws_sqs_queue" "main" {
  name                      = "${local.name_prefix}-events"
  message_retention_seconds = local.retention_days * 86400
  tags                      = local.common_tags
}
