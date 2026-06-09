# Move State — Resource Rename Refactoring

Demonstrates `terraform state mv` after renaming a resource in config.

## Files

| File | Purpose |
|------|---------|
| `provider.tf` | LocalStack AWS provider config |
| `before.tf` | Initial resource name (`aws_s3_bucket.main`) |
| `after.tf` | Renamed resource name (`aws_s3_bucket.storage`) |

## Usage

```bash
terraform init

# Apply with original name
cp before.tf main.tf
terraform apply

# Now rename in config
cp after.tf main.tf
terraform plan
# Shows: destroy old, create new (bad!)

# Fix with state mv
terraform state mv aws_s3_bucket.main aws_s3_bucket.storage

# Plan again — no changes
terraform plan

terraform destroy
```
