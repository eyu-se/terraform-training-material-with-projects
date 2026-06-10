output "queue_arn" {
  description = "ARN of the SQS queue"
  value       = aws_sqs_queue.main.arn
}

output "admin_password" {
  description = "Admin password (hidden in CLI)"
  value       = var.admin_password
  sensitive   = true
}
