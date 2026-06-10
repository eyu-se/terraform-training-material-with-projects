variable "queue_name" {
  type = string
}

variable "delay_seconds" {
  type    = number
  default = 0
}

variable "message_retention_seconds" {
  type    = number
  default = 345600
}

variable "visibility_timeout_seconds" {
  type    = number
  default = 30
}

variable "receive_wait_time_seconds" {
  type    = number
  default = 0
}

variable "tags" {
  type    = map(string)
  default = {}
}
