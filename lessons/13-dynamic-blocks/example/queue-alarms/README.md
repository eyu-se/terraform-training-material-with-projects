# Queue Alarms — Dynamic CloudWatch Metric Alarms

Demonstrates `dynamic` blocks with CloudWatch metric alarms generated from a map variable.

> Note: CloudWatch Metrics are partially supported in LocalStack. This example focuses on the Terraform pattern itself.

## Files

| File | Purpose |
|------|---------|
| `provider.tf` | LocalStack AWS provider config |
| `variables.tf` | alarm_configs map |
| `locals.tf` | Alarm metric calculations |
| `main.tf` | SQS queue + metric alarms |
| `outputs.tf` | Alarm names |

## Usage

```bash
terraform init
terraform apply

terraform destroy
```
