output "queue_names" {
  description = "Names of all created queues"
  value       = aws_sqs_queue.main[*].name
}

output "queue_ids" {
  description = "IDs of all created queues"
  value       = aws_sqs_queue.main[*].id
}
