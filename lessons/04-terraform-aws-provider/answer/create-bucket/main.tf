resource "aws_s3_bucket" "exercise" {
  bucket = "exercise-bucket-04"
}

resource "aws_dynamodb_table" "exercise" {
  name         = "ExerciseTable"
  billing_mode = "PAY_PER_REQUEST"
  hash_key     = "pk"

  attribute {
    name = "pk"
    type = "S"
  }
}

resource "aws_sqs_queue" "exercise" {
  name = "exercise-queue"
}
