# Computed Values — Conditional Locals

Demonstrates conditionals inside locals for environment-specific configuration.

## Files

| File | Purpose |
|------|---------|
| `provider.tf` | LocalStack AWS provider config |
| `variables.tf` | environment variable |
| `locals.tf` | Conditional retention, versioning, bucket name |
| `main.tf` | S3 bucket + versioning + SQS using conditional locals |

## Usage

```bash
terraform init

# Apply with dev (7 day retention, versioning enabled)
terraform apply
terraform state show aws_sqs_queue.main

# Apply with prod (365 day retention, no versioning)
terraform apply -var="environment=prod"

terraform destroy
```
