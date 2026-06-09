resource "aws_dynamodb_table" "this" {
  name         = var.table_name
  billing_mode = var.billing_mode
  hash_key     = var.hash_key

  attribute {
    name = var.hash_key
    type = "S"
  }

  tags = var.tags
}

output "table_id"  { value = aws_dynamodb_table.this.id }
output "table_arn" { value = aws_dynamodb_table.this.arn }
