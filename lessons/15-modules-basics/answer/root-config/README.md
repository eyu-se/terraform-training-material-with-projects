# Answer — Root Configuration with Multiple Module Calls

Complete example: S3 bucket module + SQS queue module + DynamoDB table module.

## Structure

```
root-config/
├── main.tf
├── provider.tf
├── outputs.tf
└── modules/
    ├── s3-bucket/
    ├── sqs-queue/
    └── dynamodb-table/
```

## Usage

```bash
terraform init
terraform apply

terraform state list
terraform output

aws --endpoint-url=http://localhost:4566 s3 ls
aws --endpoint-url=http://localhost:4566 sqs list-queues
aws --endpoint-url=http://localhost:4566 dynamodb list-tables

terraform destroy
```
