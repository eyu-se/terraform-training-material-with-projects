output "bucket_arn" {
  description = "ARN of the existing bucket"
  value       = data.aws_s3_bucket.source.arn
}

output "bucket_id" {
  description = "ID of the existing bucket"
  value       = data.aws_s3_bucket.source.id
}

output "bucket_region" {
  description = "Region of the existing bucket"
  value       = data.aws_s3_bucket.source.region
}
