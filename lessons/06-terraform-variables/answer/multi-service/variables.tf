variable "environment" {
  description = "Deployment environment"
  type        = string
  default     = "dev"

  validation {
    condition     = contains(["dev", "qa", "prod", "staging"], var.environment)
    error_message = "Environment must be dev, qa, prod, or staging."
  }
}

variable "project_name" {
  description = "Name of the project"
  type        = string
}

variable "bucket_count" {
  description = "Number of buckets to create"
  type        = number
  default     = 1
}

variable "enable_encryption" {
  description = "Enable S3 encryption"
  type        = bool
  default     = true
}

variable "tags" {
  description = "Resource tags"
  type        = map(string)
  default     = {}
}
