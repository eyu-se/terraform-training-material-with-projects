output "bucket_names" {
  description = "Bucket names keyed by for_each key"
  value       = { for k, b in aws_s3_bucket.main : k => b.id }
}

output "bucket_arns" {
  description = "Bucket ARNs keyed by for_each key"
  value       = { for k, b in aws_s3_bucket.main : k => b.arn }
}
