resource "aws_s3_bucket" "main" {
  bucket = "${local.name_prefix}-data"
  tags   = local.common_tags
}

resource "aws_dynamodb_table" "main" {
  name         = "${local.name_prefix}-table"
  billing_mode = "PAY_PER_REQUEST"
  hash_key     = "pk"

  attribute {
    name = "pk"
    type = "S"
  }

  tags = local.common_tags
}

resource "aws_sqs_queue" "main" {
  name = "${local.name_prefix}-queue"
  tags = local.common_tags
}
