variable "source_bucket" {
  description = "Name of the existing S3 bucket"
  type        = string
}

variable "source_table" {
  description = "Name of the existing DynamoDB table"
  type        = string
}
