# Answer — Multi-Call with Cross-References

Complete solution: calls all three modules at least twice, cross-references outputs between modules.

## Structure

```
multi-call/
├── main.tf
├── provider.tf
├── variables.tf
├── outputs.tf
├── terraform.tfvars
└── modules/
    ├── s3-bucket/
    ├── sqs-queue/
    └── dynamodb-table/
```

## Usage

```bash
terraform init
terraform apply

# See outputs with cross-referenced ARNs
terraform output

terraform destroy
```
