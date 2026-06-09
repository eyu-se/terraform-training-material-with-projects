output "sg_id" {
  value = aws_security_group.main.id
}

output "ingress_count" {
  value = length(aws_security_group.main.ingress)
}

output "sns_topic_arn" {
  value = aws_sns_topic.alerts.arn
}

output "logging_enabled" {
  value = var.enable_logging
}
