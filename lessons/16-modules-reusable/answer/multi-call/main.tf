module "orders_bucket" {
  source = "./modules/s3-bucket"
  bucket_name       = "answer-orders-data"
  enable_versioning = true
  tags = { Environment = var.environment, Service = "orders" }
}

module "logs_bucket" {
  source = "./modules/s3-bucket"
  bucket_name       = "answer-logs-data"
  enable_versioning = true
  tags = { Environment = var.environment, Service = "logs" }
}

module "events_queue" {
  source = "./modules/sqs-queue"
  queue_name                = "answer-order-events"
  delay_seconds             = 5
  message_retention_seconds = 604800
  tags = { Environment = var.environment, Service = "orders" }
  
}

module "notifications_queue" {
  source = "./modules/sqs-queue"
  queue_name = "answer-notifications"
  tags = { Environment = var.environment, Service = "notify" }
}

module "users_table" {
  source = "./modules/dynamodb-table"
  table_name = "answer-users"
  hash_key   = "userId"
  tags = { Environment = var.environment, Service = "users" }
}

module "orders_table" {
  source = "./modules/dynamodb-table"
  table_name = "answer-orders"
  hash_key   = "orderId"
  tags = { Environment = var.environment, Service = "orders" }
}

# Cross-reference module outputs
locals {
  crossref_tags = {
    OrdersBucketArn   = module.orders_bucket.bucket_arn
    EventsQueueArn    = module.events_queue.queue_arn
    UsersTableArn     = module.users_table.table_arn
  }
}
