# Count Conditionals — Conditional Resource Creation

Demonstrates `count` with `? 1 : 0` to conditionally create resources, plus `try()` for safe references.

## Files

| File | Purpose |
|------|---------|
| `provider.tf` | LocalStack AWS provider config |
| `variables.tf` | enable_audit bool, environment string |
| `locals.tf` | Conditional locals for naming and features |
| `main.tf` | Conditional bucket via count, conditional versioning |
| `outputs.tf` | Safe references with try() |

## Usage

```bash
terraform init

# Without audit
terraform apply
terraform output audit_bucket_name  # shows "not created"

# With audit
terraform apply -var="enable_audit=true"
terraform output audit_bucket_name  # shows bucket name

terraform destroy
```
