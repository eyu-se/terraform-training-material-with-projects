resource "aws_s3_bucket" "data" {
  bucket = local.bucket_name
}

resource "aws_s3_bucket_versioning" "data" {
  count  = local.enable_versioning ? 1 : 0
  bucket = aws_s3_bucket.data.id

  versioning_configuration {
    status = "Enabled"
  }
}

resource "aws_s3_bucket" "audit" {
  count  = local.should_create_audit ? 1 : 0
  bucket = "${var.environment}-audit-bucket"
}

resource "aws_sqs_queue" "events" {
  name                      = "${var.environment}-events"
  delay_seconds             = local.delay_seconds
  message_retention_seconds = local.retention_days * 86400
}

resource "aws_sqs_queue" "services" {
  for_each      = local.active_services
  name          = "${each.key}-${var.environment}"
  delay_seconds = each.value.delay
}
