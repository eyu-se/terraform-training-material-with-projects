output "cross_reference_tags" {
  description = "Tags with cross-referenced module outputs"
  value       = local.crossref_tags
}

output "module_count" {
  description = "Total number of module calls"
  value       = 6
}
