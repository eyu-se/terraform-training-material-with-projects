output "bucket_name" {
  value = aws_s3_bucket.main.id
}

output "retention_days" {
  value = local.retention_days
}

output "delay_seconds" {
  value = local.delay_seconds
}

output "versioning_enabled" {
  value = local.enable_versioning
}
