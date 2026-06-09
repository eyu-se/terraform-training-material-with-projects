# Read Table — Data Source for DynamoDB

Demonstrates querying an existing DynamoDB table using a data source.

## Prerequisites

Create a table manually first:

```bash
aws --endpoint-url=http://localhost:4566 dynamodb create-table \
  --table-name ExistingTable \
  --key-schema AttributeName=pk,KeyType=HASH \
  --attribute-definitions AttributeName=pk,AttributeType=S \
  --billing-mode PAY_PER_REQUEST
```

## Files

| File | Purpose |
|------|---------|
| `provider.tf` | LocalStack AWS provider config |
| `variables.tf` | Table name variable |
| `data.tf` | Data source reading the existing table |
| `outputs.tf` | Exposes table ARN, status, item count |

## Usage

```bash
terraform init
terraform apply -var="table_name=ExistingTable"

terraform output

terraform destroy
```
