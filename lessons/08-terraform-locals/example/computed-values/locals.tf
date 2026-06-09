locals {
  name_prefix = "app-${var.environment}"

  is_prod = var.environment == "prod"

  # Different retention based on environment
  retention_days = local.is_prod ? 365 : 7

  # Versioning on for non-prod, off for prod
  enable_versioning = !local.is_prod

  common_tags = {
    Environment = var.environment
    ManagedBy   = "Terraform"
  }
}
