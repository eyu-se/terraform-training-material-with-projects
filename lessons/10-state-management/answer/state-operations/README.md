# Answer — State Operations

Complete exercise solution covering state inspection, rm, mv, and import.

## Files

| File | Purpose |
|------|---------|
| `provider.tf` | LocalStack AWS provider config |
| `main.tf` | S3 bucket + DynamoDB table + SQS queue |

## Usage

### Inspect State

```bash
terraform init
terraform apply

terraform state list
terraform state show aws_s3_bucket.main
terraform state pull | python3 -c "import sys,json; d=json.load(sys.stdin); print(d['serial'], d['terraform_version'])"
```

### Remove and Re-import

```bash
# Remove queue from state (keep resource)
terraform state rm aws_sqs_queue.main
terraform plan  # shows + create

# Get queue URL
QUEUE_URL=$(aws --endpoint-url=http://localhost:4566 sqs list-queues --query 'QueueUrls[0]' --output text)
echo $QUEUE_URL

# Re-import
terraform import aws_sqs_queue.main $QUEUE_URL
terraform state list  # queue is back
```

### Rename Resource

```bash
# Edit main.tf: rename aws_s3_bucket.main to aws_s3_bucket.storage
# Without state mv:
terraform plan  # shows destroy + create

# Fix with state mv:
terraform state mv aws_s3_bucket.main aws_s3_bucket.storage
terraform plan  # no changes
```

terraform destroy
```
