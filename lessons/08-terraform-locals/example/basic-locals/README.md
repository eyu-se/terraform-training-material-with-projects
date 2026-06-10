# Basic Locals — Name Prefix and Tags

Demonstrates locals for name prefix generation and common tag reuse.

## Files

| File | Purpose |
|------|---------|
| `provider.tf` | LocalStack AWS provider config |
| `variables.tf` | environment and project_name variables |
| `locals.tf` | name_prefix and common_tags locals |
| `main.tf` | S3 bucket + DynamoDB + SQS using locals |
| `outputs.tf` | Exposes local values |

## Usage

```bash
terraform init
terraform apply

# See the computed locals in action
terraform output

terraform destroy
```
