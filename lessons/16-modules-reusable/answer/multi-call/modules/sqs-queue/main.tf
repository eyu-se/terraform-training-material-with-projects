resource "aws_sqs_queue" "this" {
  name                        = var.queue_name
  delay_seconds               = var.delay_seconds
  message_retention_seconds   = var.message_retention_seconds
  visibility_timeout_seconds  = var.visibility_timeout_seconds
  receive_wait_time_seconds   = var.receive_wait_time_seconds
  tags                        = var.tags
}

output "queue_id"  { value = aws_sqs_queue.this.id }
output "queue_arn" { value = aws_sqs_queue.this.arn }
output "queue_url" { value = aws_sqs_queue.this.url }
