output "bucket_name" {
  value = aws_s3_bucket.data.id
}

output "versioning_enabled" {
  value = local.enable_versioning
}

output "audit_bucket_name" {
  value = try(aws_s3_bucket.audit[0].id, "not created")
}

output "retention_days" {
  value = local.retention_days
}
