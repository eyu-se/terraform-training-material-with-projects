# Answer — Environment Configurations with All Conditional Patterns

Complete exercise solution: ternary naming, count for optional resources, for expressions for filtering.

## Files

| File | Purpose |
|------|---------|
| `provider.tf` | LocalStack AWS provider config |
| `variables.tf` | environment, enable_audit, service_configs |
| `locals.tf` | All conditional logic centralized |
| `main.tf` | Resources using ternary, count, for_each with filtered map |
| `outputs.tf` | Safe try() references |

## Usage

```bash
terraform init

# Dev without audit
terraform apply

# Prod with audit
terraform apply -var="environment=prod" -var="enable_audit=true"

# See filtered queues
terraform output queue_names

terraform destroy
```
