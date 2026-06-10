module "data" {
  source = "./modules/s3-bucket"

  bucket_name       = "answer-data-bucket"
  enable_versioning = true
  tags = {
    Environment = "dev"
  }
}

module "logs" {
  source = "./modules/s3-bucket"

  bucket_name       = "answer-logs-bucket"
  enable_versioning = false
  tags = {
    Environment = "dev"
    Purpose     = "logging"
  }
}

module "events" {
  source = "./modules/sqs-queue"
  queue_name    = "answer-events-queue"
  delay_seconds = 5
    tags = {
    Environment = "dev"
  }
}

module "users" {
  source = "./modules/dynamodb-table"

  table_name = "answer-users-table"
  hash_key   = "userId"
  tags = {
    Environment = "dev"
  }
  billing_mode = "PAY_PER_REQUEST"
}
