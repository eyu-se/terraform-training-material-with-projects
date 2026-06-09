output "bucket_name" {
  value = aws_s3_bucket.data.id
}

output "audit_bucket" {
  value = try(aws_s3_bucket.audit[0].id, "not created")
}

output "queue_names" {
  value = [for q in aws_sqs_queue.services : q.name]
}

output "retention_days" {
  value = local.retention_days
}

output "versioning_enabled" {
  value = local.enable_versioning
}
