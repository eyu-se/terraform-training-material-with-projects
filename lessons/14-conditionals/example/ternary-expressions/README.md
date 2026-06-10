# Ternary Expressions — Conditional Naming and Sizing

Demonstrates ternary operators in locals and resource arguments.

## Files

| File | Purpose |
|------|---------|
| `provider.tf` | LocalStack AWS provider config |
| `variables.tf` | environment string |
| `locals.tf` | Multiple ternary-based locals |
| `main.tf` | Resources using ternary-generated locals |
| `outputs.tf` | Shows computed values |

## Usage

```bash
terraform init

# Dev
terraform apply
terraform output  # small config, 7 day retention

# Prod
terraform apply -var="environment=prod"
terraform output  # large config, 365 day retention

terraform destroy
```
