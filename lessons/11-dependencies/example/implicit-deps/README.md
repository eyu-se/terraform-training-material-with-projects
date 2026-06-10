# Implicit Dependencies — Automatic via References

Demonstrates how Terraform detects dependencies through attribute references.

## Files

| File | Purpose |
|------|---------|
| `provider.tf` | LocalStack AWS provider config |
| `main.tf` | S3 bucket + versioning + public access block |

All sub-resources reference `aws_s3_bucket.main.id` — this creates implicit dependencies automatically.

## Usage

```bash
terraform init
terraform plan
# Note the creation order: bucket first, then versioning and public access

terraform apply
terraform graph

terraform destroy
```
