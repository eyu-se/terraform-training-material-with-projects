locals {
  is_prod = var.environment == "prod"
  is_dev  = var.environment == "dev"
  is_qa   = var.environment == "qa"

  # Nested ternary for three tiers
  retention_days = local.is_prod ? 365 : (local.is_qa ? 30 : 7)

  delay_seconds = local.is_prod ? 0 : (local.is_dev ? 5 : 2)

  # Different naming
  bucket_name = local.is_prod ? "prod-company-data" : "${var.environment}-company-data"

  # Feature flags
  enable_versioning = !local.is_prod
  enable_encryption = var.environment != "legacy"
}
