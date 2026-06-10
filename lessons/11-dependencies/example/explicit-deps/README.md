# Explicit Dependencies — Using depends_on

Demonstrates `depends_on` for resources with no direct reference but ordering requirements.

## Files

| File | Purpose |
|------|---------|
| `provider.tf` | LocalStack AWS provider config |
| `main.tf` | S3 bucket + SQS queue with explicit depends_on |

## Usage

```bash
terraform init
terraform apply
# Queue is created after bucket despite no direct reference

terraform graph

terraform destroy
```
