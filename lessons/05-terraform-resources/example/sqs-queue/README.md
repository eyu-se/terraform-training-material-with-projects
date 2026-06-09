# SQS Queue with Custom Attributes

Demonstrates SQS queue creation with custom delay, retention, and long-poll settings.

## Files

| File | Purpose |
|------|---------|
| `provider.tf` | LocalStack AWS provider config |
| `main.tf` | SQS queue with custom attributes |

## Usage

```bash
terraform init
terraform plan
terraform apply
terraform state show aws_sqs_queue.main
aws --endpoint-url=http://localhost:4566 sqs list-queues
terraform destroy
```
