variable "buckets" {
  description = "Bucket configurations (name -> region)"
  type        = map(string)
  default = {
    data   = "us-east-1"
    logs   = "us-east-1"
    backup = "us-east-1"
  }
}
