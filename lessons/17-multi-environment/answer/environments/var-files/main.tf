variable "environment"       { type = string }
variable "bucket_name"       { type = string }
variable "enable_versioning" { 
  type = bool 
  default = true 
  }
variable "queue_name"        { type = string }
variable "delay_seconds"     { 
  type = number
  default = 0 
}
variable "tags"              { 
  type = map(string) 
  default = {} 
}

module "bucket" {
  source = "./modules/s3-bucket"
  bucket_name       = var.bucket_name
  enable_versioning = var.enable_versioning
  tags              = var.tags
}

module "queue" {
  source = "./modules/sqs-queue"
  queue_name    = var.queue_name
  delay_seconds = var.delay_seconds
  tags          = var.tags
}

output "bucket_id" { value = module.bucket.bucket_id }
output "queue_url" { value = module.queue.queue_url }
