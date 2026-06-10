# Basic Provider — S3 Bucket via Terraform

Demonstrates the minimal AWS provider config for LocalStack and creates one S3 bucket.

## Files

| File | Purpose |
|------|---------|
| `provider.tf` | AWS provider configured for LocalStack |
| `main.tf` | Creates `terraform-first-bucket` |

## Usage

```bash
terraform init
terraform fmt
terraform validate
terraform plan
terraform apply
aws --endpoint-url=http://localhost:4566 s3 ls
terraform destroy
```
