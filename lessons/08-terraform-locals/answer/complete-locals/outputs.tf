output "name_prefix" {
  description = "Computed name prefix"
  value       = local.name_prefix
}

output "applied_tags" {
  description = "Tags applied to all resources"
  value       = local.all_tags
}

output "retention_config" {
  description = "SQS message retention in days"
  value       = local.retention_days
}

output "versioning_enabled" {
  description = "Whether versioning is enabled"
  value       = local.enable_versioning
}
