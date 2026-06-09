data "aws_dynamodb_table" "source" {
  name = var.table_name
}
