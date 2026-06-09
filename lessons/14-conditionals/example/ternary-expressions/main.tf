resource "aws_s3_bucket" "main" {
  bucket = local.bucket_name
}

resource "aws_s3_bucket_versioning" "main" {
  count  = local.enable_versioning ? 1 : 0
  bucket = aws_s3_bucket.main.id

  versioning_configuration {
    status = "Enabled"
  }
}

resource "aws_sqs_queue" "main" {
  name                      = "${var.environment}-events"
  delay_seconds             = local.delay_seconds
  message_retention_seconds = local.retention_days * 86400
}
