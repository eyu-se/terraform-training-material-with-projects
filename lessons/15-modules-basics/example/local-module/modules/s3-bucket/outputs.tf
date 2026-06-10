output "bucket_id" {
  description = "ID (name) of the bucket"
  value       = aws_s3_bucket.this.id
}

output "bucket_arn" {
  description = "ARN of the bucket"
  value       = aws_s3_bucket.this.arn
}

output "versioning_status" {
  description = "Status of versioning"
  value       = aws_s3_bucket_versioning.this.versioning_configuration[0].status
}
