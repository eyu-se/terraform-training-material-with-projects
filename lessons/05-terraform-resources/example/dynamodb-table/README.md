# DynamoDB Table with GSI

Demonstrates DynamoDB table creation with a Global Secondary Index.

## Files

| File | Purpose |
|------|---------|
| `provider.tf` | LocalStack AWS provider config |
| `main.tf` | DynamoDB table with GSI |

## Usage

```bash
terraform init
terraform plan
terraform apply
terraform state show aws_dynamodb_table.items
aws --endpoint-url=http://localhost:4566 dynamodb list-tables
terraform destroy
```
