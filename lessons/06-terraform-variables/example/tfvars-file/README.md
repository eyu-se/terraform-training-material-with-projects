# tfvars File — Multiple Environments

Demonstrates using different `.tfvars` files for dev and prod environments.

## Files

| File | Purpose |
|------|---------|
| `provider.tf` | LocalStack AWS provider config |
| `variables.tf` | Variable definitions |
| `main.tf` | S3 bucket + DynamoDB + SQS using variables |
| `dev.tfvars` | Dev environment values |
| `prod.tfvars` | Prod environment values |

## Usage

```bash
terraform init

# Dev
terraform apply -var-file="dev.tfvars"

# Notice the naming convention
aws --endpoint-url=http://localhost:4566 s3 ls

# Prod (replaces resources due to name change)
terraform apply -var-file="prod.tfvars"

# Clean up
terraform destroy
```
