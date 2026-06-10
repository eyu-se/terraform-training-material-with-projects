output "existing_bucket_arn" {
  description = "ARN of the source bucket"
  value       = data.aws_s3_bucket.source.arn
}

output "existing_table_arn" {
  description = "ARN of the source table"
  value       = data.aws_dynamodb_table.source.arn
}

output "existing_table_id" {
  description = "ID of the source table"
  value       = data.aws_dynamodb_table.source.id
}

output "account_id" {
  description = "Current AWS account ID"
  value       = data.aws_caller_identity.current.account_id
}

output "region" {
  description = "Current AWS region"
  value       = data.aws_region.current.region
}

output "queue_tags" {
  description = "Tags on the created queue"
  value       = aws_sqs_queue.driven.tags_all
}
