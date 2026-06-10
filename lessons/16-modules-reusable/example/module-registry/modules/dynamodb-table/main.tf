resource "aws_dynamodb_table" "this" {
  name         = var.table_name
  billing_mode = var.billing_mode
  hash_key     = var.hash_key
  range_key    = var.range_key

  attribute {
    name = var.hash_key
    type = var.attribute_type
  }

  dynamic "attribute" {
    for_each = var.range_key != null ? [1] : []
    content {
      name = var.range_key
      type = var.attribute_type
    }
  }

  tags = var.tags
}

output "table_id"   { value = aws_dynamodb_table.this.id }
output "table_arn"  { value = aws_dynamodb_table.this.arn }
output "table_name" { value = aws_dynamodb_table.this.name }
