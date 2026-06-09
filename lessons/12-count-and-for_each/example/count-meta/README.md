# Count Meta-Argument — Creating N Resources

Demonstrates `count` with a list variable to create multiple SQS queues.

## Files

| File | Purpose |
|------|---------|
| `provider.tf` | LocalStack AWS provider config |
| `variables.tf` | queue_names list variable |
| `main.tf` | SQS queues with count |
| `outputs.tf` | Outputs all queue names |

## Usage

```bash
terraform init
terraform apply

# Verify
terraform state list
aws --endpoint-url=http://localhost:4566 sqs list-queues

terraform destroy
```
