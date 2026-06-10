# Lesson 16: Reusable Modules

## Learning Objectives

- Design modules for reusability across projects
- Use module outputs to expose complex data
- Create a module registry-compatible module
- Use the Terraform Registry for public modules

---

## 1. Characteristics of a Reusable Module

A well-designed reusable module follows these principles:

| Principle | Description |
|-----------|-------------|
| **Minimal required inputs** | Only require what is truly unique to each call |
| **Sensible defaults** | Optional parameters have good defaults |
| **Complete outputs** | Expose all useful attributes callers may need |
| **No hardcoded values** | Everything configurable via variables |
| **Consistent naming** | Use `this` as the resource name, not project-specific names |
| **Documentation** | `README.md` explaining usage |

### Naming Convention

Modules should avoid hardcoded prefixes in resource names:

```hcl
# Bad — hardcoded project name in module
resource "aws_s3_bucket" "this" {
  bucket = "myproject-${var.bucket_name}"  # can't be reused by other projects
}

# Good — let the caller control the name
resource "aws_s3_bucket" "this" {
  bucket = var.bucket_name  # caller provides full name
}
```

---

## 2. Module Pattern: S3 Bucket

```hcl
# modules/s3-bucket/variables.tf
variable "bucket_name" {
  description = "Name of the S3 bucket"
  type        = string
}

variable "enable_versioning" {
  description = "Enable versioning on the bucket"
  type        = bool
  default     = true
}

variable "sse_algorithm" {
  description = "Server-side encryption algorithm (AES256 or aws:kms)"
  type        = string
  default     = "AES256"
}

variable "force_destroy" {
  description = "Allow deletion of non-empty bucket"
  type        = bool
  default     = false
}

variable "tags" {
  description = "Tags to apply to the bucket"
  type        = map(string)
  default     = {}
}

# modules/s3-bucket/main.tf
resource "aws_s3_bucket" "this" {
  bucket        = var.bucket_name
  force_destroy = var.force_destroy
  tags          = var.tags
}

resource "aws_s3_bucket_versioning" "this" {
  bucket = aws_s3_bucket.this.id

  versioning_configuration {
    status = var.enable_versioning ? "Enabled" : "Suspended"
  }
}

resource "aws_s3_bucket_server_side_encryption_configuration" "this" {
  bucket = aws_s3_bucket.this.id

  rule {
    apply_server_side_encryption_by_default {
      sse_algorithm = var.sse_algorithm
    }
  }
}

resource "aws_s3_bucket_public_access_block" "this" {
  bucket = aws_s3_bucket.this.id

  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true
}

# modules/s3-bucket/outputs.tf
output "bucket_id" {
  description = "Bucket name"
  value       = aws_s3_bucket.this.id
}

output "bucket_arn" {
  description = "Bucket ARN"
  value       = aws_s3_bucket.this.arn
}

output "bucket_domain_name" {
  description = "Bucket domain name"
  value       = aws_s3_bucket.this.bucket_domain_name
}

output "bucket_regional_domain_name" {
  description = "Bucket regional domain name"
  value       = aws_s3_bucket.this.bucket_regional_domain_name
}
```

---

## 3. Module Pattern: SQS Queue

```hcl
# modules/sqs-queue/variables.tf
variable "queue_name" {
  description = "Name of the SQS queue"
  type        = string
}

variable "delay_seconds" {
  description = "Delay in seconds (0-900)"
  type        = number
  default     = 0
}

variable "message_retention_seconds" {
  description = "Message retention in seconds (60-1209600)"
  type        = number
  default     = 345600
}

variable "visibility_timeout_seconds" {
  description = "Visibility timeout in seconds (0-43200)"
  type        = number
  default     = 30
}

variable "receive_wait_time_seconds" {
  description = "Long poll wait time (0-20)"
  type        = number
  default     = 0
}

variable "tags" {
  description = "Tags to apply"
  type        = map(string)
  default     = {}
}

# modules/sqs-queue/main.tf
resource "aws_sqs_queue" "this" {
  name                        = var.queue_name
  delay_seconds               = var.delay_seconds
  message_retention_seconds   = var.message_retention_seconds
  visibility_timeout_seconds  = var.visibility_timeout_seconds
  receive_wait_time_seconds   = var.receive_wait_time_seconds
  tags                        = var.tags
}

# modules/sqs-queue/outputs.tf
output "queue_id" {
  description = "Queue ID (URL)"
  value       = aws_sqs_queue.this.id
}

output "queue_arn" {
  description = "Queue ARN"
  value       = aws_sqs_queue.this.arn
}

output "queue_url" {
  description = "Queue URL"
  value       = aws_sqs_queue.this.url
}
```

---

## 4. Module Pattern: DynamoDB Table

```hcl
# modules/dynamodb-table/variables.tf
variable "table_name" {
  description = "Name of the DynamoDB table"
  type        = string
}

variable "hash_key" {
  description = "Partition key attribute name"
  type        = string
  default     = "pk"
}

variable "range_key" {
  description = "Sort key attribute name (optional)"
  type        = string
  default     = null
}

variable "billing_mode" {
  description = "Billing mode (PAY_PER_REQUEST or PROVISIONED)"
  type        = string
  default     = "PAY_PER_REQUEST"
}

variable "tags" {
  description = "Tags to apply"
  type        = map(string)
  default     = {}
}

# modules/dynamodb-table/main.tf
resource "aws_dynamodb_table" "this" {
  name         = var.table_name
  billing_mode = var.billing_mode
  hash_key     = var.hash_key
  range_key    = var.range_key

  dynamic "attribute" {
    for_each = var.range_key != null ? [1, 2] : [1]
    content {
      name = attribute.key == 0 ? var.hash_key : var.range_key
      type = "S"
    }
  }

  attribute {
    name = var.hash_key
    type = "S"
  }

  tags = var.tags
}

# modules/dynamodb-table/outputs.tf
output "table_id" {
  value = aws_dynamodb_table.this.id
}

output "table_arn" {
  value = aws_dynamodb_table.this.arn
}

output "table_name" {
  value = aws_dynamodb_table.this.name
}
```

---

## 5. Calling Reusable Modules

```hcl
# main.tf — root configuration
module "orders_bucket" {
  source = "./modules/s3-bucket"

  bucket_name       = "app-orders-data"
  enable_versioning = true
  tags = {
    Environment = var.environment
    Service     = "orders"
  }
}

module "events_queue" {
  source = "./modules/sqs-queue"

  queue_name                = "app-order-events"
  delay_seconds             = 5
  message_retention_seconds = 604800

  tags = {
    Environment = var.environment
    Service     = "orders"
  }
}

module "orders_table" {
  source = "./modules/dynamodb-table"

  table_name = "app-orders"
  hash_key   = "orderId"

  tags = {
    Environment = var.environment
    Service     = "orders"
  }
}
```

---

## 6. Using Terraform Registry Modules

Public modules are available at [registry.terraform.io](https://registry.terraform.io):

```hcl
module "vpc" {
  source  = "terraform-aws-modules/vpc/aws"
  version = "5.0.0"

  name = "my-vpc"
  cidr = "10.0.0.0/16"

  azs             = ["us-east-1a", "us-east-1b"]
  private_subnets = ["10.0.1.0/24", "10.0.2.0/24"]
  public_subnets  = ["10.0.101.0/24", "10.0.102.0/24"]

  enable_nat_gateway = true
  enable_vpn_gateway = true

  tags = {
    Environment = "dev"
  }
}
```

---

## 7. Module Documentation

Every module should have a `README.md`:

````markdown
# S3 Bucket Module

Creates an S3 bucket with versioning, encryption, and public access blocking.

## Usage

```hcl
module "bucket" {
  source = "./modules/s3-bucket"

  bucket_name       = "my-app-data"
  enable_versioning = true
  tags = {
    Environment = "dev"
  }
}
```

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|----------|
| bucket_name | Name of the S3 bucket | `string` | — | yes |
| enable_versioning | Enable versioning | `bool` | `true` | no |
| sse_algorithm | Encryption algorithm | `string` | `"AES256"` | no |
| force_destroy | Allow non-empty deletion | `bool` | `false` | no |
| tags | Resource tags | `map(string)` | `{}` | no |

## Outputs

| Name | Description |
|------|-------------|
| bucket_id | Bucket name |
| bucket_arn | Bucket ARN |
| bucket_domain_name | Bucket domain name |
````

---

## 8. Key Takeaways

- Reusable modules have **minimal required inputs** and **sensible defaults**
- Never hardcode project-specific values inside a module
- Expose all useful attributes as outputs
- Use `this` as the resource local name for consistency
- Document inputs and outputs in a README
- The Terraform Registry provides thousands of community modules
- Module version pinning (`version = "5.0.0"`) ensures reproducibility


## example and exercise repo url 
[https://github.com/eyu-se/terraform-training-material-with-projects](https://github.com/eyu-se/terraform-training-material-with-projects)

## Trainer - Eyuel M.