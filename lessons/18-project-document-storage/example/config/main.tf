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

variable "environment" {
  type    = string
  default = "dev"
}

variable "project_name" {
  type    = string
  default = "docstore"
}

locals {
  bucket_name = "${var.project_name}-${var.environment}-documents"
  table_name  = "document-index-${var.environment}"
  tags = {
    Environment = var.environment
    Project     = var.project_name
    Service     = "document-storage"
  }
}

module "documents" {
  source = "./modules/document-bucket"

  environment       = var.environment
  bucket_name       = local.bucket_name
  enable_versioning = true
  force_destroy     = var.environment != "prod"
  tags              = local.tags
}

module "index" {
  source = "./modules/document-index"

  environment = var.environment
  table_name  = local.table_name
  tags        = local.tags
}

output "bucket_name" {
  value = module.documents.bucket_id
}

output "bucket_arn" {
  value = module.documents.bucket_arn
}

output "table_name" {
  value = module.index.table_id
}

output "table_arn" {
  value = module.index.table_arn
}

output "storage_endpoint" {
  value = "s3://${module.documents.bucket_id}"
}
