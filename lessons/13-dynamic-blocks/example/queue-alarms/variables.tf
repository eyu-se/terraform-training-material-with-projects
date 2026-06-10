variable "alarm_configs" {
  description = "Alarm configurations"
  type = map(object({
    threshold      = number
    period         = number
    evaluation_periods = number
  }))
  default = {
    high_cpu    = { threshold = 90, period = 60, evaluation_periods = 2 }
    low_cpu     = { threshold = 10, period = 300, evaluation_periods = 1 }
    high_memory = { threshold = 85, period = 120, evaluation_periods = 3 }
  }
}
