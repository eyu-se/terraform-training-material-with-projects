# Ingress Rules — Dynamic Security Group

Demonstrates `dynamic` blocks with a list of objects to create security group ingress rules.

## Files

| File | Purpose |
|------|---------|
| `provider.tf` | LocalStack AWS provider config |
| `variables.tf` | ingress_rules list of objects |
| `locals.tf` | Optional filtering |
| `main.tf` | Security group with dynamic ingress |
| `outputs.tf` | Exposes SG ID and ingress count |

## Usage

```bash
terraform init
terraform apply

# Verify rules
terraform state show aws_security_group.main

# Conditional: disable SSH
terraform apply -var="enable_ssh=false"

terraform destroy
```
