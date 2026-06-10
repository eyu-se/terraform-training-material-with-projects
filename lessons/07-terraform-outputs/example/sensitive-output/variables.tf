variable "admin_password" {
  description = "Admin password (sensitive)"
  type        = string
  sensitive   = true
}

variable "queue_name" {
  description = "Name of the SQS queue"
  type        = string
  default     = "sensitive-demo-queue"
}
