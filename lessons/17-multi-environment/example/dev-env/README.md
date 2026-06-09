# Dev Environment — Directory-per-Env Approach

Deploys the S3 bucket module with dev-specific variables. Shared module sourced from `../modules/s3-bucket/`.

## Files

| File | Purpose |
|------|---------|
| `provider.tf` | LocalStack AWS provider config |
| `variables.tf` | environment, bucket_name, enable_versioning, tags |
| `main.tf` | Calls s3-bucket module |
| `terraform.tfvars` | Dev-specific values |

## Usage

```bash
terraform init
terraform apply

terraform state list

terraform destroy
```
