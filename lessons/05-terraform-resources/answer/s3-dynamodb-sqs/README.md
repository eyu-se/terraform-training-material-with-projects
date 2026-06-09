# Answer — S3 + DynamoDB + SQS with Outputs

Complete exercise solution with all three resources plus output values.

## Files

| File | Purpose |
|------|---------|
| `provider.tf` | LocalStack AWS provider config |
| `main.tf` | Versioned S3 bucket, DynamoDB with GSI, custom SQS queue |
| `outputs.tf` | Outputs showing ARNs of all resources |

## Usage

```bash
terraform init
terraform plan
terraform apply

# Verify
aws --endpoint-url=http://localhost:4566 s3 ls
aws --endpoint-url=http://localhost:4566 dynamodb list-tables
aws --endpoint-url=http://localhost:4566 sqs list-queues

terraform destroy
```
