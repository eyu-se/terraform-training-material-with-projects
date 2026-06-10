locals {
  name_prefix = "${var.project_name}-${var.environment}"
  is_prod     = var.environment == "prod"

  # Conditional configuration
  retention_days    = local.is_prod ? 365 : 7
  enable_versioning = !local.is_prod

  # Tag normalization
  common_tags = {
    Environment = var.environment
    ManagedBy   = "Terraform"
    Project     = var.project_name
  }

  all_tags = merge(local.common_tags, var.extra_tags)
}
