# Exercise 16: Reusable Modules

## Prerequisites

- LocalStack running
- Terraform installed

## Task 1: Create the Module Registry Structure

Create this directory structure:

```
reusable-modules/
├── main.tf
├── provider.tf
├── variables.tf
├── outputs.tf
└── modules/
    ├── s3-bucket/        (from lesson 15, enhanced)
    ├── sqs-queue/        (from lesson 15, enhanced)
    └── dynamodb-table/   (new)
```

Copy and enhance the modules from lesson 15. Each module should have:
- Full set of optional variables with good defaults
- Multiple related resources (versioning, encryption, public access for S3)
- Complete outputs

**Deliverable:** List the files in each module directory.

---

## Task 2: Call S3 Module with Minimal Inputs

In root `main.tf`, call the S3 module with only the required input:

```hcl
module "simple_bucket" {
  source = "./modules/s3-bucket"

  bucket_name = "reusable-simple-bucket"
}
```

Apply and verify. The bucket should have versioning enabled (default) and AES256 encryption (default).

**Deliverable:** Paste `terraform state show module.simple_bucket.aws_s3_bucket_versioning.this` showing `Enabled`.

---

## Task 3: Call S3 Module with Full Overrides

Add a second module call with all overrides:

```hcl
module "configured_bucket" {
  source = "./modules/s3-bucket"

  bucket_name       = "reusable-configured-bucket"
  enable_versioning = false
  sse_algorithm     = "AES256"
  force_destroy     = true
  tags = {
    Environment = "dev"
    Purpose     = "testing"
  }
}
```

Apply and verify versioning is `Suspended` and encryption uses `AES256`.

**Deliverable:** Paste `terraform state show module.configured_bucket.aws_s3_bucket_versioning.this`.

---

## Task 4: Call All Three Modules

Add calls for SQS queue and DynamoDB table modules:

```hcl
module "events" {
  source = "./modules/sqs-queue"

  queue_name    = "reusable-events"
  delay_seconds = 10
}

module "users" {
  source = "./modules/dynamodb-table"

  table_name = "reusable-users"
  hash_key   = "userId"
}
```

Apply and verify all three module types are created.

**Deliverable:** Paste `terraform state list` showing module-prefixed resources for all three modules.

---

## Task 5: Cross-Reference Module Outputs

Use outputs from one module as inputs to another:

```hcl
module "data_bucket" {
  source = "./modules/s3-bucket"
  bucket_name = "reusable-crossref-data"
}

module "notifications" {
  source = "./modules/sqs-queue"
  queue_name = "reusable-crossref-notify"
}

# Use module outputs
locals {
  crossref_tags = {
    BucketArn = module.data_bucket.bucket_arn
    QueueArn  = module.notifications.queue_arn
  }
}
```

Add a root output that shows these tags.

**Deliverable:** Paste the root outputs showing the cross-referenced ARNs.

---

## Bonus Challenge

Add conditional configuration to the DynamoDB module: when `range_key` is provided, the module should also create a Local Secondary Index (LSI). When it's `null`, only the hash key attribute should be defined.

Hint: Use a `dynamic "attribute"` block with a conditional `for_each`.
