# Inspect State — S3 + DynamoDB + SQS State Commands

Demonstrates `state list`, `state show`, and `state pull` commands.

## Files

| File | Purpose |
|------|---------|
| `provider.tf` | LocalStack AWS provider config |
| `main.tf` | S3 bucket + DynamoDB table + SQS queue |
| `terraform.tfvars` | Variable values |

## Usage

```bash
terraform init
terraform apply

# Inspect state
terraform state list
terraform state show aws_s3_bucket.main
terraform state pull | python3 -m json.tool

terraform destroy
```
