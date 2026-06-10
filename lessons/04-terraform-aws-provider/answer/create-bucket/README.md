# Answer — Create S3 Bucket, DynamoDB Table, SQS Queue

Exercise solution with all resources in one config.

## Files

| File | Purpose |
|------|---------|
| `provider.tf` | AWS provider configured for LocalStack |
| `main.tf` | Creates bucket `exercise-bucket-04`, table `ExerciseTable`, queue `exercise-queue` |

## Usage

```bash
terraform init
terraform plan
terraform apply

# Verify
aws --endpoint-url=http://localhost:4566 s3 ls
aws --endpoint-url=http://localhost:4566 dynamodb list-tables
aws --endpoint-url=http://localhost:4566 sqs list-queues

# Get ARNs
terraform state show aws_s3_bucket.exercise
terraform state show aws_dynamodb_table.exercise
terraform state show aws_sqs_queue.exercise

terraform destroy
```
