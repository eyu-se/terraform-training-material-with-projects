output "queue_names" {
  description = "Queue names created via count"
  value       = aws_sqs_queue.main[*].name
}

output "bucket_names" {
  description = "Bucket names created via for_each"
  value       = { for k, b in aws_s3_bucket.main : k => b.id }
}

output "audit_bucket" {
  description = "Conditionally created audit bucket"
  value       = var.create_audit_bucket ? aws_s3_bucket.audit[0].id : null
}
