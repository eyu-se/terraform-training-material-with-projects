# Exercise 08: Terraform Locals

## Prerequisites

- LocalStack running
- Terraform installed

## Task 1: Name Prefix Locals

Create a directory `locals-exercise`. Create:

1. `provider.tf` — standard LocalStack AWS provider
2. `variables.tf` with:
   - `environment` (string, default `"dev"`)
   - `project_name` (string, default `"myapp"`)
3. `locals.tf` with:
   - `name_prefix` = `"${var.project_name}-${var.environment}"`
   - `common_tags` map with Environment, ManagedBy, Project

Run `terraform validate`.

**Deliverable:** Paste the contents of `locals.tf`.

---

## Task 2: Resources Using Locals

Create `main.tf` with:

1. `aws_s3_bucket` named `"${local.name_prefix}-data"` with `local.common_tags`
2. `aws_dynamodb_table` named `"${local.name_prefix}-table"` with `local.common_tags`
3. `aws_sqs_queue` named `"${local.name_prefix}-queue"` with `local.common_tags`

Apply and verify.

**Deliverable:** Paste `terraform state list` output showing 3 resources.

---

## Task 3: Conditional Locals

Add to `locals.tf`:

1. `is_prod` = `var.environment == "prod"`
2. `retention_days` = `local.is_prod ? 365 : 7`
3. `enable_versioning` = `!local.is_prod` (versioning off in prod — or reverse for your scenario)

Update `main.tf` to use `local.retention_days` in `aws_sqs_queue` and `local.enable_versioning` in `aws_s3_bucket_versioning`.

Apply with `environment = "dev"`, then `environment = "prod"`, and observe the difference.

**Deliverable:** Paste the SQS queue retention settings from `terraform state show` for both dev and prod.

---

## Task 4: Merged Tags

Add to `variables.tf`:
```hcl
variable "extra_tags" {
  description = "Additional tags"
  type        = map(string)
  default     = {}
}
```

Add to `locals.tf`:
```hcl
all_tags = merge(local.common_tags, var.extra_tags)
```

Update all resources to use `local.all_tags`. Add `extra_tags` to `terraform.tfvars`:

```hcl
environment = "dev"
project_name = "myapp"
extra_tags = {
  Owner = "team-platform"
  CostCenter = "12345"
}
```

Apply and inspect the tags on any resource.

**Deliverable:** Paste the tags output from `terraform state show aws_s3_bucket.main`.

---

## Task 5: Create Outputs for Locals

Add to `outputs.tf`:

1. An output `name_prefix` showing the computed prefix
2. An output `applied_tags` showing `local.all_tags`
3. An output `retention_config` showing `local.retention_days`

Apply and view all outputs.

**Deliverable:** Paste the `Outputs:` section.

---

## Bonus Challenge

Add a local that uses the `formatdate` and `timestamp` functions to create a build timestamp tag:

```hcl
locals {
  build_timestamp = formatdate("YYYY-MM-DD'T'HH:mm:ss", timestamp())
}
```

Add `BuildTimestamp = local.build_timestamp` to your `common_tags`. Apply and observe the timestamp. What happens when you apply again — does the timestamp change?
