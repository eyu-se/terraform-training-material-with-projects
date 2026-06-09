resource "aws_s3_bucket" "first" {
  bucket = "terraform-first-bucket"
}

resource "aws_dynamodb_table" "first" {
  name         = "terraform-first-table"
  billing_mode = "PAY_PER_REQUEST"
  hash_key     = "id"

  attribute {
    name = "id"
    type = "S"
  }
}

resource "aws_sqs_queue" "first" {
  name = "terraform-first-queue"
}
