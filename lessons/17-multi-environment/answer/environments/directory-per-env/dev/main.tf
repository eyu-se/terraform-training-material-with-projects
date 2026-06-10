module "bucket" {
  source = "../modules/s3-bucket"

  bucket_name       = var.bucket_name
  enable_versioning = var.enable_versioning
  tags              = var.tags
}
