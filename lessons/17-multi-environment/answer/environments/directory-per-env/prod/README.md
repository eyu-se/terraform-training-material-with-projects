# Prod Environment — Directory-per-Env Approach

Same module as dev, different tfvars values. Demonstrates environment isolation.

## Files

| File | Purpose |
|------|---------|
| `provider.tf` | LocalStack AWS provider config |
| `variables.tf` | Same variables as dev |
| `main.tf` | Calls same s3-bucket module |
| `terraform.tfvars` | Prod-specific values (no versioning) |

## Usage

```bash
terraform init
terraform apply

terraform state list

terraform destroy
```
