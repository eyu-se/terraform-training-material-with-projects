# Exercise 06: Terraform Variables

## Prerequisites

- LocalStack running
- Terraform installed

## Task 1: Define Variables

Create a directory `variable-exercise` with:

1. `provider.tf` — standard LocalStack AWS provider (include all endpoints and skip flags)
2. `variables.tf` with these variables:

| Variable | Type | Default | Description |
|----------|------|---------|-------------|
| `environment` | `string` | `"dev"` | Deployment environment |
| `project_name` | `string` | (none — required) | Name of the project |
| `bucket_count` | `number` | `1` | Number of buckets to create |
| `enable_encryption` | `bool` | `true` | Enable S3 encryption |
| `tags` | `map(string)` | `{}` | Resource tags |

3. Run `terraform validate` — it should pass.

**Deliverable:** Paste the contents of `variables.tf`.

---

## Task 2: Use Variables in Resources

Create `main.tf` that uses all variables:

1. `aws_s3_bucket` named `"${var.project_name}-${var.environment}-data"` with tags
2. `aws_s3_bucket_versioning` that enables versioning
3. `aws_s3_bucket_server_side_encryption_configuration` that uses `AES256`
4. `aws_dynamodb_table` named `"${var.project_name}-${var.environment}-table"`
5. `aws_sqs_queue` named `"${var.environment}-events"`

Run `terraform validate`.

**Deliverable:** Paste `terraform plan` output showing `3 to add, 0 to change, 0 to destroy`.

---

## Task 3: Create `terraform.tfvars`

Create `terraform.tfvars`:

```hcl
environment    = "dev"
project_name   = "myapp"
bucket_count   = 2
enable_encryption = true
tags = {
  Environment = "dev"
  Project     = "myapp"
  ManagedBy   = "Terraform"
}
```

Run `terraform apply`.

**Deliverable:** Paste the output of `terraform state list` and the ARNs of created resources.

---

## Task 4: Use a Different `-var-file`

1. Create `prod.tfvars` with `environment = "prod"` and `project_name = "myapp"`
2. Run `terraform plan -var-file="prod.tfvars"` — note it shows replacement of resources
3. Run `terraform destroy` (cleans up dev resources)

**Question:** What happens when you run `plan` with `prod.tfvars`? Why does Terraform want to replace resources instead of modifying them?

---

## Task 5: Override via CLI

1. Apply again with the dev config
2. Override a variable via CLI:
   ```bash
   terraform apply -var="environment=staging"
   ```
3. Run `terraform destroy`

**Deliverable:** Show the SQS queue name from the state — is it `dev-events` or `staging-events`?

---

## Bonus Challenge

Add variable validation to your `environment` variable:

```hcl
validation {
  condition     = contains(["dev", "qa", "prod", "staging"], var.environment)
  error_message = "Environment must be dev, qa, prod, or staging."
}
```

Then test it by passing an invalid value:

```bash
terraform plan -var="environment=invalid"
```

What error do you get?
