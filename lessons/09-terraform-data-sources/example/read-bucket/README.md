# Read Bucket — Data Source for S3

Demonstrates querying an existing S3 bucket using a data source.

## Prerequisites

Create a bucket manually first:

```bash
aws --endpoint-url=http://localhost:4566 s3 mb s3://existing-source-bucket
```

## Files

| File | Purpose |
|------|---------|
| `provider.tf` | LocalStack AWS provider config |
| `variables.tf` | Bucket name variable |
| `data.tf` | Data source reading the existing bucket |
| `outputs.tf` | Exposes bucket ARN, region, tags |

## Usage

```bash
terraform init
terraform apply -var="bucket_name=existing-source-bucket"

# View the data source attributes
terraform output

terraform destroy
```
