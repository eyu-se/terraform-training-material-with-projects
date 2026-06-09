output "bucket_arn" {
  description = "ARN of the versioned S3 bucket"
  value       = aws_s3_bucket.versioned.arn
}

output "bucket_name" {
  description = "Name of the versioned S3 bucket"
  value       = aws_s3_bucket.versioned.id
}

output "dynamodb_table_arn" {
  description = "ARN of the Products DynamoDB table"
  value       = aws_dynamodb_table.products.arn
}

output "dynamodb_table_name" {
  description = "Name of the Products DynamoDB table"
  value       = aws_dynamodb_table.products.name
}

output "sqs_queue_arn" {
  description = "ARN of the event SQS queue"
  value       = aws_sqs_queue.events.arn
}

output "sqs_queue_url" {
  description = "URL of the event SQS queue"
  value       = aws_sqs_queue.events.url
}
