# Exercise 15: Modules Basics

## Prerequisites

- LocalStack running
- Terraform installed

## Task 1: Create an S3 Bucket Module

Create a directory structure:

```
modules-exercise/
├── main.tf
├── provider.tf
├── outputs.tf
└── modules/
    └── s3-bucket/
        ├── main.tf
        ├── variables.tf
        └── outputs.tf
```

Create the `s3-bucket` module that accepts:
- `bucket_name` (string, required)
- `enable_versioning` (bool, default `true`)
- `tags` (map(string), default `{}`)

The module should create `aws_s3_bucket` and `aws_s3_bucket_versioning` resources.

**Deliverable:** Paste the contents of `modules/s3-bucket/main.tf`.

---

## Task 2: Call the Module from Root

In the root `main.tf`:

```hcl
module "data" {
  source = "./modules/s3-bucket"

  bucket_name       = "module-data-bucket"
  enable_versioning = true
  tags = {
    Environment = "dev"
    Module      = "s3-bucket"
  }
}
```

Add `provider.tf` (standard LocalStack config) and run:

```bash
terraform init
terraform apply
```

**Deliverable:** Paste the output of `terraform state list` showing the module path prefix.

---

## Task 3: Add Module Outputs and Root Outputs

Add to `modules/s3-bucket/outputs.tf`:

```hcl
output "bucket_id"  { value = aws_s3_bucket.this.id }
output "bucket_arn" { value = aws_s3_bucket.this.arn }
output "versioning_status" { value = aws_s3_bucket_versioning.this.versioning_configuration[0].status }
```

Add to root `outputs.tf`:

```hcl
output "module_bucket_arn" {
  value = module.data.bucket_arn
}
```

Apply and verify the output.

**Deliverable:** Paste `terraform output module_bucket_arn`.

---

## Task 4: Call the Same Module Twice

Create a second module call for a logs bucket:

```hcl
module "logs" {
  source = "./modules/s3-bucket"

  bucket_name       = "module-logs-bucket"
  enable_versioning = false
  tags = {
    Environment = "dev"
    Purpose     = "logging"
  }
}
```

Add a root output for the logs bucket ARN. Apply and verify both buckets exist.

**Deliverable:** Paste `terraform state list` showing resources from both module calls.

---

## Task 5: Create an SQS Queue Module

Create `modules/sqs-queue/` with variables for `queue_name` and `delay_seconds`. Call it from root alongside the bucket modules:

```hcl
module "events" {
  source = "./modules/sqs-queue"

  queue_name    = "module-events-queue"
  delay_seconds = 5
}
```

Apply and verify all three module calls work.

**Deliverable:** Paste `aws --endpoint-url=http://localhost:4566 sqs list-queues` output showing the queue.

---

## Bonus Challenge

Create a DynamoDB table module (`modules/dynamodb-table/`) that accepts:

- `table_name` (string, required)
- `hash_key` (string, default `"pk"`)
- `billing_mode` (string, default `"PAY_PER_REQUEST"`)
- `tags` (map(string), default `{}`)

Call it from root and verify all four modules work together.
