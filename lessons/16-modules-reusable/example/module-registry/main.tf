module "simple_bucket" {
  source      = "./modules/s3-bucket"
  bucket_name = "reusable-simple-bucket"
}

module "configured_bucket" {
  source = "./modules/s3-bucket"

  bucket_name       = "reusable-configured-bucket"
  enable_versioning = false
  force_destroy     = true
  tags = {
    Environment = "dev"
    Purpose     = "testing"
  }
}

module "events" {
  source        = "./modules/sqs-queue"
  queue_name    = "reusable-events"
  delay_seconds = 10
}

module "users" {
  source     = "./modules/dynamodb-table"
  table_name = "reusable-users"
  hash_key   = "userId"
}
