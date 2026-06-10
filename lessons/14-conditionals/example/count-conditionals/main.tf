resource "aws_s3_bucket" "data" {
  bucket = "${local.bucket_prefix}-data-bucket"
}

resource "aws_s3_bucket_versioning" "data" {
  count  = local.enable_versioning ? 1 : 0
  bucket = aws_s3_bucket.data.id

  versioning_configuration {
    status = "Enabled"
  }
}

resource "aws_s3_bucket" "audit" {
  count  = var.enable_audit ? 1 : 0
  bucket = "${var.environment}-audit-bucket"
}

resource "aws_sqs_queue" "events" {
  name                      = "${var.environment}-events"
  message_retention_seconds = local.retention_days * 86400
}
