variable "environment" {
  description = "Deployment environment"
  type        = string
  default     = "dev"
}

variable "project_name" {
  description = "Project name"
  type        = string
  default     = "myapp"
}

variable "extra_tags" {
  description = "Additional tags"
  type        = map(string)
  default     = {}
}
