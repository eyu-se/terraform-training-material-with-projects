# Answer — Cross-Reference with Data Sources

Complete exercise solution: reads existing resources via data sources and creates a new resource with merged tags.

## Prerequisites

Run these CLI commands first:

```bash
aws --endpoint-url=http://localhost:4566 s3 mb s3://manual-source-bucket
aws --endpoint-url=http://localhost:4566 s3api put-bucket-tagging \
  --bucket manual-source-bucket \
  --tagging 'TagSet=[{Key=Source,Value=CLI},{Key=Purpose,Value=DataSources}]'
aws --endpoint-url=http://localhost:4566 dynamodb create-table \
  --table-name ManualTable \
  --key-schema AttributeName=pk,KeyType=HASH \
  --attribute-definitions AttributeName=pk,AttributeType=S \
  --billing-mode PAY_PER_REQUEST
```

## Files

| File | Purpose |
|------|---------|
| `provider.tf` | LocalStack AWS provider config |
| `variables.tf` | source_bucket and source_table variables |
| `data.tf` | Data sources for S3, DynamoDB, caller identity, region |
| `main.tf` | SQS queue with tags from data sources + IAM policy |
| `outputs.tf` | Exposes all data source attributes |

## Usage

```bash
terraform init
terraform plan \
  -var="source_bucket=manual-source-bucket" \
  -var="source_table=ManualTable"

terraform apply \
  -var="source_bucket=manual-source-bucket" \
  -var="source_table=ManualTable"

# Verify
terraform state show aws_sqs_queue.driven
aws --endpoint-url=http://localhost:4566 s3api get-bucket-policy --bucket manual-source-bucket

terraform destroy
```
