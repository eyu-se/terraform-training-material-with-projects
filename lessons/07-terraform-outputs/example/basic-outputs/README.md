# Basic Outputs — S3 Bucket Output Values

Demonstrates output blocks that expose bucket name, ARN, and domain.

## Files

| File | Purpose |
|------|---------|
| `provider.tf` | LocalStack AWS provider config |
| `variables.tf` | Bucket name variable |
| `main.tf` | S3 bucket resource |
| `outputs.tf` | Output values for bucket attributes |

## Usage

```bash
terraform init
terraform plan
terraform apply

# Query outputs
terraform output
terraform output bucket_name
terraform output -json

terraform destroy
```
