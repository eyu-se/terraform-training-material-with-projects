resource "aws_s3_bucket" "main" {
  bucket = "state-inspect-bucket"
}

resource "aws_dynamodb_table" "main" {
  name         = "StateInspectTable"
  billing_mode = "PAY_PER_REQUEST"
  hash_key     = "pk"

  attribute {
    name = "pk"
    type = "S"
  }
}

resource "aws_sqs_queue" "main" {
  name = "state-inspect-queue"
}
