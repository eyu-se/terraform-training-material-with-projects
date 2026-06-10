output "queue_arn" {
  value = aws_sqs_queue.main.arn
}

output "alarm_names" {
  value = keys(var.alarm_configs)
}
