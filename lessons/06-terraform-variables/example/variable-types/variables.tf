variable "bucket_name" {
  description = "Name of the S3 bucket"
  type        = string
}

variable "enable_encryption" {
  description = "Enable S3 server-side encryption"
  type        = bool
  default     = true
}

variable "tags" {
  description = "Tags for the bucket"
  type        = map(string)
  default     = {}
}
