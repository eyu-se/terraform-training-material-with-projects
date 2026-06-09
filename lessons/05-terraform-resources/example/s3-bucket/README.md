# S3 Bucket with Versioning and Encryption

Demonstrates S3 with sub-resources for versioning and encryption.

## Files

| File | Purpose |
|------|---------|
| `provider.tf` | LocalStack AWS provider config |
| `main.tf` | S3 bucket + versioning + encryption |

## Usage

```bash
terraform init
terraform plan
terraform apply
terraform state show aws_s3_bucket.versioned
aws --endpoint-url=http://localhost:4566 s3 ls
terraform destroy
```
