locals {
  is_prod           = var.environment == "prod"
  enable_versioning = !local.is_prod
  retention_days    = local.is_prod ? 365 : 7
  bucket_prefix     = local.is_prod ? "prod" : var.environment
}
