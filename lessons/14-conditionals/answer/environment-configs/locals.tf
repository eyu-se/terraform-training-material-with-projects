locals {
  is_prod           = var.environment == "prod"
  is_dev            = var.environment == "dev"
  is_qa             = var.environment == "qa"

  # Nested ternary for three tiers
  retention_days = local.is_prod ? 365 : (local.is_qa ? 30 : 7)
  delay_seconds  = local.is_prod ? 0 : (local.is_dev ? 5 : 2)

  # Conditional naming
  bucket_name       = local.is_prod ? "prod-company-data" : "${var.environment}-company-data"
  enable_versioning = !local.is_prod

  # Feature flags
  should_create_audit = var.enable_audit || local.is_prod

  # Filtered queues from for expression
  active_services = {
    for name, config in var.service_configs : name => config
    if config.enabled
  }
}
