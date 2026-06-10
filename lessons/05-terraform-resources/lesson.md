# Lesson 05: Terraform Resources

## Learning Objectives

- Understand Terraform resource blocks in detail
- Learn resource arguments, attributes, and meta-arguments
- Create S3 buckets with versioning, encryption, and public access settings
- Create DynamoDB tables with various configurations
- Create SQS queues with attributes
- Understand resource dependencies between services

---

## 1. Resource Block Anatomy

Every Terraform resource follows this structure:

```hcl
resource "resource_type" "local_name" {
  argument1 = "value1"
  argument2 = "value2"

  # Nested configuration blocks
  nested_block {
    key = "value"
  }
}
```

| Part | Meaning | Example |
|------|---------|---------|
| `resource` | Block type — declares a resource | — |
| `"resource_type"` | The type of resource to create | `"aws_s3_bucket"`, `"aws_dynamodb_table"` |
| `"local_name"` | A name you choose to reference this resource within Terraform | `"main"`, `"data"`, `"logs"` |
| `arguments` | Configuration parameters for the resource | `bucket`, `region`, `acl` |
| `attributes` | Values exported by the resource after creation | `id`, `arn`, `bucket_domain_name` |
| `nested blocks` | Sub-configurations with their own arguments | `attribute`, `logging`, `server_side_encryption_configuration` |

---

## 2. S3 Bucket — Arguments and Attributes

### Basic Bucket

```hcl
resource "aws_s3_bucket" "main" {
  bucket = "my-tf-bucket-05"
}
```

### Bucket with Versioning

S3 versioning is configured as a separate resource in the AWS provider v5+:

```hcl
resource "aws_s3_bucket" "main" {
  bucket = "my-tf-bucket-05"
}

resource "aws_s3_bucket_versioning" "main" {
  bucket = aws_s3_bucket.main.id

  versioning_configuration {
    status = "Enabled"
  }
}
```

### Bucket with Encryption

```hcl
resource "aws_s3_bucket" "main" {
  bucket = "my-tf-bucket-05"
}

resource "aws_s3_bucket_server_side_encryption_configuration" "main" {
  bucket = aws_s3_bucket.main.id

  rule {
    apply_server_side_encryption_by_default {
      sse_algorithm = "AES256"
    }
  }
}
```

### Bucket with Public Access Block

```hcl
resource "aws_s3_bucket" "main" {
  bucket = "my-tf-bucket-05"
}

resource "aws_s3_bucket_public_access_block" "main" {
  bucket = aws_s3_bucket.main.id

  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true
}
```

### Key Arguments for `aws_s3_bucket`

| Argument | Description | Required |
|----------|-------------|----------|
| `bucket` | Name of the bucket | No (Terraform generates one if omitted) |
| `force_destroy` | Allow deletion of non-empty bucket | No (default `false`) |
| `tags` | Key-value map of tags | No |

### Key Attributes (read after creation)

| Attribute | Description |
|-----------|-------------|
| `id` | Same as bucket name |
| `arn` | ARN: `arn:aws:s3:::bucket-name` |
| `bucket_domain_name` | DNS name: `bucket-name.s3.amazonaws.com` |
| `region` | Region where bucket was created |

---

## 3. DynamoDB Table — Arguments and Attributes

```hcl
resource "aws_dynamodb_table" "main" {
  name         = "TfTable"
  billing_mode = "PAY_PER_REQUEST"
  hash_key     = "pk"

  attribute {
    name = "pk"
    type = "S"
  }

  # Optional: Global Secondary Index
  global_secondary_index {
    name     = "gsi_name"
    hash_key = "gsi_pk"
    projection_type = "ALL"
  }

  tags = {
    Environment = "learning"
  }
}
```

### Key Arguments for `aws_dynamodb_table`

| Argument | Description | Required |
|----------|-------------|----------|
| `name` | Table name | Yes |
| `billing_mode` | `"PAY_PER_REQUEST"` or `"PROVISIONED"` | No (default `"PROVISIONED"`) |
| `hash_key` | Partition key attribute name | Yes |
| `range_key` | Sort key attribute name | No |
| `attribute` | Attribute definitions (name + type) | Yes (must match keys) |
| `global_secondary_index` | Optional GSI configuration | No |
| `local_secondary_index` | Optional LSI configuration | No |
| `ttl` | Time-to-live settings | No |
| `tags` | Key-value tags | No |

### Attribute Types

| Type | Code |
|------|------|
| String | `"S"` |
| Number | `"N"` |
| Binary | `"B"` |

### Key Attributes

| Attribute | Description |
|-----------|-------------|
| `id` | Table name |
| `arn` | Full ARN |
| `stream_arn` | DynamoDB Stream ARN (if streams enabled) |

---

## 4. SQS Queue — Arguments and Attributes

```hcl
resource "aws_sqs_queue" "main" {
  name = "tf-queue-05"

  # Optional attributes
  delay_seconds             = 0
  max_message_size          = 2048
  message_retention_seconds = 86400
  receive_wait_time_seconds = 0
  visibility_timeout_seconds = 30
}
```

### Key Arguments for `aws_sqs_queue`

| Argument | Description | Default |
|----------|-------------|---------|
| `name` | Queue name | Required |
| `name_prefix` | Prefix for auto-generated name | No |
| `delay_seconds` | Delivery delay (0–900) | `0` |
| `max_message_size` | Max message size (1024–262144) | `262144` (256 KB) |
| `message_retention_seconds` | Retention (60–1209600) | `345600` (4 days) |
| `receive_wait_time_seconds` | Long-poll wait (0–20) | `0` |
| `visibility_timeout_seconds` | Visibility timeout (0–43200) | `30` |
| `fifo_queue` | Whether queue is FIFO | `false` |
| `tags` | Key-value tags | No |

### Key Attributes

| Attribute | Description |
|-----------|-------------|
| `id` | Queue URL |
| `arn` | Full ARN |
| `url` | Queue URL (same as `id`) |

---

## 5. Cross-Resource References

Resources can reference attributes of other resources using the `resource_type.local_name.attribute` syntax:

```hcl
resource "aws_s3_bucket" "main" {
  bucket = "tf-bucket-references"
}

resource "aws_s3_bucket_versioning" "main" {
  bucket = aws_s3_bucket.main.id  # <-- cross-reference
  versioning_configuration {
    status = "Enabled"
  }
}
```

This creates an **implicit dependency**: Terraform knows it must create the S3 bucket before the versioning configuration.

---

## 6. Complete Example

```hcl
# provider.tf
provider "aws" {
  access_key = "test"
  secret_key = "test"
  region     = "us-east-1"

  endpoints {
    s3       = "http://localhost:4566"
    dynamodb = "http://localhost:4566"
    sqs      = "http://localhost:4566"
  }

  skip_credentials_validation = true
  skip_requesting_account_id  = true
  skip_metadata_api_check     = true
  skip_region_validation      = true
  s3_use_path_style           = true
}

# main.tf
resource "aws_s3_bucket" "data" {
  bucket = "tf-resources-data-bucket"
  tags = {
    Name = "DataBucket"
  }
}

resource "aws_s3_bucket_versioning" "data" {
  bucket = aws_s3_bucket.data.id
  versioning_configuration {
    status = "Enabled"
  }
}

resource "aws_dynamodb_table" "items" {
  name         = "Items"
  billing_mode = "PAY_PER_REQUEST"
  hash_key     = "item_id"

  attribute {
    name = "item_id"
    type = "S"
  }

  global_secondary_index {
    name            = "category-index"
    hash_key        = "category"
    projection_type = "ALL"
  }

  attribute {
    name = "category"
    type = "S"
  }
}

resource "aws_sqs_queue" "orders" {
  name                      = "orders-queue"
  delay_seconds             = 0
  message_retention_seconds = 86400  # 1 day
}
```

---

## 7. Key Takeaways

- Each resource block has a **type**, a **local name**, **arguments** (inputs), and **attributes** (outputs)
- Sub-resources like `aws_s3_bucket_versioning` are separate resources that attach to a parent
- Cross-resource references (`aws_s3_bucket.main.id`) create implicit dependencies — Terraform orders creation automatically
- DynamoDB requires `attribute` blocks that match the `hash_key` and any `global_secondary_index` key names
- SQS queues have sensible defaults for most attributes — you only need to set `name`

## example and exercise repo url 
[https://github.com/eyu-se/terraform-training-material-with-projects](https://github.com/eyu-se/terraform-training-material-with-projects)

## Trainer - Eyuel M.
