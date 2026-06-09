# Using count with a list
resource "aws_sqs_queue" "main" {
  count = length(var.queue_names)
  name  = "${var.queue_names[count.index]}-queue"
}

# Using for_each with a map
resource "aws_s3_bucket" "main" {
  for_each = var.buckets
  bucket   = "bucket-${each.key}"
}

# Conditional count
resource "aws_s3_bucket" "audit" {
  count  = var.create_audit_bucket ? 1 : 0
  bucket = "audit-bucket"
}
