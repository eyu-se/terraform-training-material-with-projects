# Answer — Dynamic Policies (SNS + Security Group)

Complete exercise solution: security group with dynamic ingress, SNS with dynamic subscriptions, S3 with dynamic logging.

## Files

| File | Purpose |
|------|---------|
| `provider.tf` | LocalStack AWS provider config |
| `variables.tf` | ingress_rules, subscriptions, enable_logging, enable_ssh |
| `locals.tf` | Filtered rules |
| `main.tf` | SG with dynamic ingress, SNS with dynamic subs, S3 with dynamic logging |

## Usage

```bash
terraform init
terraform apply

# See all generated blocks
terraform state show aws_security_group.main
terraform state show aws_s3_bucket.main

# Disable SSH
terraform apply -var="enable_ssh=false"

# Disable logging
terraform apply -var="enable_logging=false"

terraform destroy
```
