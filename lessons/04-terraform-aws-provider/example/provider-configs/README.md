# Provider Configs — S3 + DynamoDB + SQS

Extends the basic provider to create three resources demonstrating the AWS provider works with multiple services.

## Files

| File | Purpose |
|------|---------|
| `provider.tf` | Same AWS provider config for LocalStack |
| `main.tf` | Creates S3 bucket, DynamoDB table, and SQS queue |

## Usage

```bash
terraform init
terraform fmt
terraform validate
terraform plan
terraform apply

# Verify all three
aws --endpoint-url=http://localhost:4566 s3 ls
aws --endpoint-url=http://localhost:4566 dynamodb list-tables
aws --endpoint-url=http://localhost:4566 sqs list-queues

terraform destroy
```
