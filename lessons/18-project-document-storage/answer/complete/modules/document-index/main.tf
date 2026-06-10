resource "aws_dynamodb_table" "index" {
  name         = var.table_name
  billing_mode = "PAY_PER_REQUEST"
  hash_key     = "document_id"

  attribute {
    name = "document_id"
    type = "S"
  }

  global_secondary_index {
    name            = "filename-index"
    hash_key        = "filename"
    projection_type = "ALL"
  }

  attribute {
    name = "filename"
    type = "S"
  }

  tags = var.tags
}
