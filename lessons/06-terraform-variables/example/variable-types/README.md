# Variable Types — Single Resource with Variables

Demonstrates basic variable types: string, number, bool, map.

## Files

| File | Purpose |
|------|---------|
| `provider.tf` | LocalStack AWS provider config |
| `variables.tf` | Variable definitions for name, count, encryption, tags |
| `main.tf` | S3 bucket using variables |
| `terraform.tfvars` | Variable values |

## Usage

```bash
terraform init
terraform plan
terraform apply
terraform destroy
```
