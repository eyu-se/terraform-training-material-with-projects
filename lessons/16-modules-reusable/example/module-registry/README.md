# Module Registry — Three Reusable Modules

Reusable S3 bucket, SQS queue, and DynamoDB table modules with full variables, outputs, and sensible defaults.

## Structure

```
module-registry/
├── main.tf
├── provider.tf
├── variables.tf
├── outputs.tf
└── modules/
    ├── s3-bucket/
    │   ├── main.tf
    │   ├── variables.tf
    │   └── outputs.tf
    ├── sqs-queue/
    │   ├── main.tf
    │   ├── variables.tf
    │   └── outputs.tf
    └── dynamodb-table/
        ├── main.tf
        ├── variables.tf
        └── outputs.tf
```

## Usage

```bash
terraform init
terraform apply

# Verify
terraform state list
terraform output

terraform destroy
```
