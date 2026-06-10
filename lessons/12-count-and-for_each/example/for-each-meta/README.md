# for_each Meta-Argument — Creating Resources from Maps

Demonstrates `for_each` with a map variable to create S3 buckets with different configs.

## Files

| File | Purpose |
|------|---------|
| `provider.tf` | LocalStack AWS provider config |
| `variables.tf` | buckets map variable |
| `main.tf` | S3 buckets with for_each |
| `outputs.tf` | Outputs bucket names keyed by for_each key |

## Usage

```bash
terraform init
terraform apply

# Verify
terraform state list
aws --endpoint-url=http://localhost:4566 s3 ls

terraform destroy
```
