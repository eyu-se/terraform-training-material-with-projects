output "sg_id" {
  description = "Security group ID"
  value       = aws_security_group.main.id
}

output "ingress_count" {
  description = "Number of ingress rules"
  value       = length(aws_security_group.main.ingress)
}
