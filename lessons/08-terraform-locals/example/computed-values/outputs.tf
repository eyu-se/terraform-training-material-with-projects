output "retention_days" {
  description = "SQS message retention in days"
  value       = local.retention_days
}

output "enable_versioning" {
  description = "Whether S3 versioning is enabled"
  value       = local.enable_versioning
}

output "name_prefix" {
  description = "Computed name prefix"
  value       = local.name_prefix
}
