variable "environment" {
  description = "Deployment environment"
  type        = string
  default     = "dev"
}

variable "enable_audit" {
  description = "Whether to create audit resources"
  type        = bool
  default     = false
}

variable "service_configs" {
  description = "Service configurations with enabled flag"
  type = map(object({
    enabled = bool
    delay   = number
  }))
  default = {
    orders  = { enabled = true, delay = 0 }
    billing = { enabled = true, delay = 5 }
    legacy  = { enabled = false, delay = 10 }
  }
}
