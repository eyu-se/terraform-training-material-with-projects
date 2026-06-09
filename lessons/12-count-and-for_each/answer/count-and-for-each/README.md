# Answer — Count and for_each Combined

Complete exercise solution demonstrating count, for_each, and conditional count.

## Files

| File | Purpose |
|------|---------|
| `provider.tf` | LocalStack AWS provider config |
| `variables.tf` | queue_names list, buckets map, create_audit_bucket bool |
| `main.tf` | Queues with count, buckets with for_each, conditional audit bucket |
| `outputs.tf` | Outputs showing list and map from count/for_each |

## Usage

```bash
terraform init

# Apply with all defaults
terraform apply

# Test removal from middle of list (count issue)
# Edit variables.tf: remove "logs" from queue_names
terraform plan
# Notice: events-queue is shown as destroyed + recreated

# Test removal from map (for_each safe)
# Edit variables.tf: remove "logs" from buckets map
terraform plan
# Notice: only bucket-logs is removed, no shifts

# Test conditional
terraform apply -var="create_audit_bucket=true"
terraform apply -var="create_audit_bucket=false"

terraform destroy
```
