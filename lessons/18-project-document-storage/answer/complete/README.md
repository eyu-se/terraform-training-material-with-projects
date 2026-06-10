# Answer — Document Storage Complete Solution

Full project with verified modules and test commands.

## Structure

```
complete/
├── main.tf
├── provider.tf
├── variables.tf
├── locals.tf
├── outputs.tf
├── modules/
│   ├── document-bucket/
│   │   ├── main.tf
│   │   ├── variables.tf
│   │   └── outputs.tf
│   └── document-index/
│       ├── main.tf
│       ├── variables.tf
│       └── outputs.tf
└── verify.sh
```

## Usage

```bash
terraform init
terraform apply

# Verify infrastructure
bash verify.sh

# Or manually test
aws --endpoint-url=http://localhost:4566 s3 ls
aws --endpoint-url=http://localhost:4566 dynamodb list-tables

terraform destroy
```
