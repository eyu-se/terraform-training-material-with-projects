# Lesson 07: Terraform Outputs

## Learning Objectives

- Understand what output values are and why they are useful
- Define output blocks to expose resource attributes
- Use `terraform output` to retrieve values
- Mark outputs as sensitive
- Use outputs for cross-module references

---

## 1. What are Output Values?

Output values let you **export** information about your infrastructure after `terraform apply`. They are displayed in the CLI and queryable via `terraform output`.

```hcl
output "bucket_name" {
  value = aws_s3_bucket.main.id
}
```

After apply, you see:

```
Outputs:

bucket_name = "my-bucket"
```

### Why use outputs?

| Use Case | Example |
|----------|---------|
| **Quick access to ARNs and IDs** | Get bucket ARN without browsing the Web UI |
| **Pass data between modules** | Feed module A's output into module B |
| **Script automation** | `terraform output -json` for programmatic access |
| **Documentation** | Show key resource identifiers after provisioning |

---

## 2. Output Block Anatomy

```hcl
output "output_name" {
  description = "Human-readable explanation"
  value       = <expression>
  sensitive   = true      # optional, hides from CLI
  depends_on  = []        # optional, explicit dependency
}
```

| Argument | Description | Required |
|----------|-------------|----------|
| `value` | The expression to evaluate and return | Yes |
| `description` | Human-readable explanation | No |
| `sensitive` | If `true`, hides value in CLI (still accessible) | No (default `false`) |
| `depends_on` | Explicit dependency on other resources | No |

---

## 3. Basic Outputs

```hcl
# outputs.tf

output "s3_bucket_arn" {
  description = "ARN of the S3 bucket"
  value       = aws_s3_bucket.main.arn
}

output "s3_bucket_name" {
  description = "Name of the S3 bucket"
  value       = aws_s3_bucket.main.id
}

output "dynamodb_table_arn" {
  description = "ARN of the DynamoDB table"
  value       = aws_dynamodb_table.main.arn
}

output "dynamodb_table_name" {
  description = "Name of the DynamoDB table"
  value       = aws_dynamodb_table.main.name
}

output "sqs_queue_arn" {
  description = "ARN of the SQS queue"
  value       = aws_sqs_queue.main.arn
}

output "sqs_queue_url" {
  description = "URL of the SQS queue"
  value       = aws_sqs_queue.main.url
}
```

After `terraform apply`, you see:

```
Outputs:

dynamodb_table_arn   = "arn:aws:dynamodb:us-east-1:000000000000:table/AppTable"
dynamodb_table_name  = "AppTable"
s3_bucket_arn        = "arn:aws:s3:::my-bucket"
s3_bucket_name       = "my-bucket"
sqs_queue_arn        = "arn:aws:sqs:us-east-1:000000000000:my-queue"
sqs_queue_url        = "http://sqs.us-east-1.localhost.localstack.cloud:4566/000000000000/my-queue"
```

---

## 4. Complex Output Expressions

Outputs can contain any Terraform expression, not just direct attribute references:

```hcl
# Combined string
output "bucket_domain" {
  value = "${aws_s3_bucket.main.bucket_domain_name}"
}

# Conditional output
output "versioning_status" {
  value = aws_s3_bucket_versioning.main.versioning_configuration[0].status
}

# Map of all values
output "resource_identifiers" {
  value = {
    bucket_arn = aws_s3_bucket.main.arn
    table_arn  = aws_dynamodb_table.main.arn
    queue_arn  = aws_sqs_queue.main.arn
  }
}

# Formatted string
output "connection_string" {
  value = "endpoint=${aws_sqs_queue.main.url};region=us-east-1"
}
```

---

## 5. Sensitive Outputs

Use `sensitive = true` for values you don't want displayed in CLI output:

```hcl
output "db_password" {
  description = "Database password"
  value       = var.db_password
  sensitive   = true
}
```

In the CLI:

```
Apply complete! Resources: 1 added.

Outputs:

db_password = (sensitive value)
```

You can still retrieve the value:

```bash
# Show all (sensitive values hidden)
terraform output

# Show sensitive values
terraform output db_password

# Show as JSON (includes sensitive)
terraform output -json
```

---

## 6. Using `terraform output` Command

```bash
# List all outputs
terraform output

# Get a specific output
terraform output bucket_domain

# Get in JSON format
terraform output -json

# Get raw value (no quotes)
terraform output -raw bucket_domain

```

### Usage in Scripts

```bash
#!/bin/bash
BUCKET_NAME=$(terraform output -raw bucket_name)
QUEUE_URL=$(terraform output -raw sqs_queue_url)

aws --endpoint-url=http://localhost:4566 s3 ls s3://$BUCKET_NAME/
aws --endpoint-url=http://localhost:4566 sqs send-message \
  --queue-url $QUEUE_URL \
  --message-body "Automated message"
```

---

## 7. Outputs for Cross-Module References

When you split your config into modules, outputs become the **public API** of a module:

```
root/
  ├── main.tf
  ├── modules/
  │   └── storage/
  │       ├── main.tf
  │       ├── outputs.tf   # <-- exposes bucket_arn, table_name
  │       └── variables.tf
  └── main.tf              # <-- uses module.storage.bucket_arn
```

Module outputs are accessed as `module.<module_name>.<output_name>`.

---

## 8. Complete Example

```hcl
# outputs.tf
output "bucket_arn" {
  description = "ARN of the created S3 bucket"
  value       = aws_s3_bucket.main.arn
}

output "bucket_name" {
  description = "Name of the created S3 bucket"
  value       = aws_s3_bucket.main.id
}

output "table_arn" {
  description = "ARN of the DynamoDB table"
  value       = aws_dynamodb_table.main.arn
}

output "table_name" {
  description = "Name of the DynamoDB table"
  value       = aws_dynamodb_table.main.name
}

output "queue_arn" {
  description = "ARN of the SQS queue"
  value       = aws_sqs_queue.main.arn
}

output "queue_url" {
  description = "URL of the SQS queue"
  value       = aws_sqs_queue.main.url
}

output "all_resources" {
  description = "Map of all created resource identifiers"
  value = {
    bucket = aws_s3_bucket.main.arn
    table  = aws_dynamodb_table.main.arn
    queue  = aws_sqs_queue.main.arn
  }
}
```

---

## 9. Key Takeaways

- Outputs display resource attributes after `terraform apply`
- `terraform output -raw <name>` gets plain values for scripts
- `terraform output -json` returns all outputs as JSON
- `sensitive = true` hides values from CLI display but not from `terraform output -json`
- Outputs are the primary mechanism for passing data between modules
- Outputs can contain complex expressions: maps, lists, conditionals, string interpolation

## example and exercise repo url 
[https://github.com/eyu-se/terraform-training-material-with-projects](https://github.com/eyu-se/terraform-training-material-with-projects)

## Trainer - Eyuel M.