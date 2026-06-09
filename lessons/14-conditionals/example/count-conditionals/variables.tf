variable "environment" {
  description = "Deployment environment"
  type        = string
  default     = "dev"
}

variable "enable_audit" {
  description = "Whether to create audit bucket"
  type        = bool
  default     = false
}
