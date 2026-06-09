# Sensitive Output — Hiding Values in CLI

Demonstrates `sensitive = true` to hide passwords and secrets from CLI output.

## Files

| File | Purpose |
|------|---------|
| `provider.tf` | LocalStack AWS provider config |
| `variables.tf` | Variable with `sensitive = true` |
| `main.tf` | SQS queue (dummy resource) |
| `outputs.tf` | Sensitive output that hides the value |
| `terraform.tfvars` | Contains the sensitive value |

## Usage

```bash
terraform init
terraform apply

# Notice: password shows as (sensitive value)
terraform output

# Retrieve the actual value
terraform output admin_password

# JSON output reveals sensitive values
terraform output -json

terraform destroy
```
