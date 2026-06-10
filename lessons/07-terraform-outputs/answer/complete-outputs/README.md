# Answer — Complete Outputs for S3 + DynamoDB + SQS

Exercise solution with all output types: basic, complex, sensitive, and combined.

## Files

| File | Purpose |
|------|---------|
| `provider.tf` | LocalStack AWS provider config |
| `variables.tf` | environment, project_name, db_password variables |
| `main.tf` | S3 bucket + versioning, DynamoDB table, SQS queue |
| `outputs.tf` | Basic ARNs, combined map, summary string, sensitive password |
| `terraform.tfvars` | Variable values |

## Usage

```bash
terraform init
terraform apply

# Inspect outputs
terraform output
terraform output -json
terraform output -raw bucket_name

# Test sensitive
terraform output admin_password

# Use output in script
BUCKET=$(terraform output -raw bucket_name)
echo "test" | aws --endpoint-url=http://localhost:4566 s3 cp - "s3://$BUCKET/test.txt"

terraform destroy
```
