output "name_prefix" {
  description = "Computed name prefix"
  value       = local.name_prefix
}

output "applied_tags" {
  description = "Tags applied to all resources"
  value       = local.common_tags
}
