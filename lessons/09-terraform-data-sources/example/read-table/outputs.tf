output "table_arn" {
  description = "ARN of the existing table"
  value       = data.aws_dynamodb_table.source.arn
}

output "table_name" {
  description = "Name of the existing table"
  value       = data.aws_dynamodb_table.source.name
}

output "table_id" {
  description = "ID of the existing table"
  value       = data.aws_dynamodb_table.source.id
}

output "billing_mode" {
  description = "Billing mode of the table"
  value       = data.aws_dynamodb_table.source.billing_mode
}
