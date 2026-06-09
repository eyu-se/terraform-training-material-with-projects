variable "queue_names" {
  description = "Names for the SQS queues"
  type        = list(string)
  default     = ["alerts", "logs", "events"]
}
