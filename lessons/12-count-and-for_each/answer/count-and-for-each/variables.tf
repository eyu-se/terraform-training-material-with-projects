variable "queue_names" {
  description = "Names for SQS queues"
  type        = list(string)
  default     = ["alerts", "logs", "events"]
}

variable "buckets" {
  description = "Bucket configurations"
  type        = map(string)
  default = {
    data   = "us-east-1"
    logs   = "us-east-1"
    backup = "us-east-1"
  }
}

variable "create_audit_bucket" {
  description = "Whether to create an audit bucket"
  type        = bool
  default     = false
}
