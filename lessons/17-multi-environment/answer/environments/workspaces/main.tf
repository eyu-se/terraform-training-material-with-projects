locals {
  environment = terraform.workspace
  is_prod     = terraform.workspace == "prod"

  bucket_name = "ws-${terraform.workspace}-data"
  queue_name  = "ws-${terraform.workspace}-events"

  enable_versioning = !local.is_prod
  delay_seconds     = local.is_prod ? 0 : 5
}

provider "aws" {
  access_key = "test"
  secret_key = "test"
  region     = "us-east-1"

  endpoints {
    s3       = "http://localhost:4566"
    dynamodb = "http://localhost:4566"
    sqs      = "http://localhost:4566"
  }

  skip_credentials_validation = true
  skip_requesting_account_id  = true
  skip_metadata_api_check     = true
  skip_region_validation      = true
  s3_use_path_style           = true
}

module "bucket" {
  source = "./modules/s3-bucket"
  bucket_name       = local.bucket_name
  enable_versioning = local.enable_versioning
  tags = { Environment = terraform.workspace }
}

module "queue" {
  source = "./modules/sqs-queue"
  queue_name    = local.queue_name
  delay_seconds = local.delay_seconds
  tags = { Environment = terraform.workspace }
}

output "bucket_name" { value = module.bucket.bucket_id }
output "queue_url"   { value = module.queue.queue_url }
