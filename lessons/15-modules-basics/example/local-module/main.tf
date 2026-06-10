module "data" {
  source = "./modules/s3-bucket"

  bucket_name       = "module-data-bucket"
  enable_versioning = true
  tags = {
    Environment = "dev"
    Module      = "s3-bucket"
  }
}

module "logs" {
  source = "./modules/s3-bucket"

  bucket_name       = "module-logs-bucket"
  enable_versioning = false
  tags = {
    Environment = "dev"
    Purpose     = "logging"
  }
}
