# Answer — Multi-Service with Variables

Complete exercise solution with variables, tfvars, and three services.

## Files

| File | Purpose |
|------|---------|
| `provider.tf` | LocalStack AWS provider config |
| `variables.tf` | All variable definitions with validation |
| `main.tf` | S3 + DynamoDB + SQS using variables |
| `terraform.tfvars` | Dev environment values |
| `prod.tfvars` | Prod environment values |

## Usage

```bash
terraform init

# Apply with dev defaults
terraform apply

# Verify queue name
terraform state show aws_sqs_queue.main

# Plan with prod
terraform plan -var-file="prod.tfvars"

# Override via CLI
terraform apply -var="environment=staging"

# Clean up
terraform destroy
```
