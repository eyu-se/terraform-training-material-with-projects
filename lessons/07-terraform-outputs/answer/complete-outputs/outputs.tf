output "bucket_name" {
  description = "Name of the S3 bucket"
  value       = aws_s3_bucket.main.id
}

output "bucket_arn" {
  description = "ARN of the S3 bucket"
  value       = aws_s3_bucket.main.arn
}

output "table_name" {
  description = "Name of the DynamoDB table"
  value       = aws_dynamodb_table.main.name
}

output "table_arn" {
  description = "ARN of the DynamoDB table"
  value       = aws_dynamodb_table.main.arn
}

output "queue_name" {
  description = "Name of the SQS queue"
  value       = aws_sqs_queue.main.name
}

output "queue_arn" {
  description = "ARN of the SQS queue"
  value       = aws_sqs_queue.main.arn
}

output "queue_url" {
  description = "URL of the SQS queue"
  value       = aws_sqs_queue.main.url
}

output "all_arns" {
  description = "Map of all resource ARNs"
  value = {
    bucket  = aws_s3_bucket.main.arn
    table   = aws_dynamodb_table.main.arn
    queue   = aws_sqs_queue.main.arn
  }
}

output "summary" {
  description = "Human-readable infrastructure summary"
  value       = "Bucket: ${aws_s3_bucket.main.id}, Table: ${aws_dynamodb_table.main.name}, Queue: ${aws_sqs_queue.main.name}"
}

output "bucket_region" {
  description = "Region where the bucket was created"
  value       = aws_s3_bucket.main.region
}

output "admin_password" {
  description = "Database admin password (sensitive)"
  value       = var.db_password
  sensitive   = true
}
