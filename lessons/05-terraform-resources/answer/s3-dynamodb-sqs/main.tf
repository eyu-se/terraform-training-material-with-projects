resource "aws_s3_bucket" "versioned" {
  bucket = "versioned-bucket-eyu"
}

resource "aws_s3_bucket_versioning" "versioned" {
  bucket = aws_s3_bucket.versioned.id
  versioning_configuration {
    status = "Enabled"
  }
}

resource "aws_s3_bucket_server_side_encryption_configuration" "versioned" {
  bucket = aws_s3_bucket.versioned.id
  rule {
    apply_server_side_encryption_by_default {
      sse_algorithm = "AES256"
    }
  }
}

resource "aws_dynamodb_table" "products" {
  name         = "Products"
  billing_mode = "PAY_PER_REQUEST"
  hash_key     = "product_id"

  attribute {
    name = "product_id"
    type = "S"
  }

  global_secondary_index {
    name            = "category-index"
    hash_key        = "category"
    projection_type = "ALL"
  }

  attribute {
    name = "category"
    type = "S"
  }
}

resource "aws_sqs_queue" "events" {
  name                        = "event-queue"
  delay_seconds               = 5
  message_retention_seconds   = 604800
  receive_wait_time_seconds   = 10
}
