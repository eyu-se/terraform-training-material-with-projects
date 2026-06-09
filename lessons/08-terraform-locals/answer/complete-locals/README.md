# Answer — Complete Locals Example

Exercise solution with conditional locals, merged tags, retention, and versioning.

## Files

| File | Purpose |
|------|---------|
| `provider.tf` | LocalStack AWS provider config |
| `variables.tf` | environment, project_name, extra_tags variables |
| `locals.tf` | name_prefix, conditional logic, merged tags |
| `main.tf` | S3 + DynamoDB + SQS using all locals |
| `outputs.tf` | Exposes computed local values |

## Usage

```bash
terraform init

# Dev (7 day retention, versioning on)
terraform apply

# Prod (365 day retention, versioning off)
terraform apply -var="environment=prod"

# With extra tags
terraform apply -var='extra_tags={Owner="team"}'

terraform destroy
```
