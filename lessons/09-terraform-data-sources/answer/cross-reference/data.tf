data "aws_s3_bucket" "source" {
  bucket = var.source_bucket
}

data "aws_dynamodb_table" "source" {
  name = var.source_table
}

data "aws_caller_identity" "current" {}

data "aws_region" "current" {}
