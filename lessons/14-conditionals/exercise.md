# Exercise 14: Conditionals

## Prerequisites

- LocalStack running
- Terraform installed

## Task 1: Ternary Expressions

Create a directory `conditionals-exercise`. Create:

1. `provider.tf` — standard LocalStack config
2. `variables.tf` with `environment` (string, default `"dev"`)
3. `locals.tf` with:
   - `is_prod` = `var.environment == "prod"`
   - `retention_days` = `local.is_prod ? 365 : 7`
   - `bucket_name` = `local.is_prod ? "prod-data" : "${var.environment}-data"`
4. `main.tf` with `aws_s3_bucket` using `local.bucket_name` and `aws_sqs_queue` using `local.retention_days`

Apply and verify the naming with both `dev` and `prod`.

**Deliverable:** Paste the bucket name from `terraform state show` for both environments.

---

## Task 2: Conditional Resource Creation

Add a variable `enable_audit` (bool, default `false`).

Create `aws_s3_bucket.audit` with:

```hcl
resource "aws_s3_bucket" "audit" {
  count  = var.enable_audit ? 1 : 0
  bucket = "${var.environment}-audit"
}
```

Apply with `enable_audit = true`, then with `enable_audit = false`. Check `terraform state list` each time.

**Deliverable:** Paste `terraform state list` output for both cases.

---

## Task 3: Safe References with `try`

Add an output for the audit bucket that uses `try()`:

```hcl
output "audit_bucket_name" {
  value = try(aws_s3_bucket.audit[0].id, "not created")
}
```

Apply with `enable_audit = false`. The output should show `"not created"` instead of an error.

**Question:** What would happen without `try()` when `count = 0`?

---

## Task 4: `for` Expressions for Filtering

Add to your config:

```hcl
variable "service_configs" {
  type = map(object({
    enabled = bool
    delay   = number
  }))
  default = {
    orders  = { enabled = true, delay = 0 }
    billing = { enabled = true, delay = 5 }
    legacy  = { enabled = false, delay = 10 }
  }
}

locals {
  active_services = {
    for name, config in var.service_configs : name => config
    if config.enabled
  }
}

resource "aws_sqs_queue" "services" {
  for_each = local.active_services
  name     = "${each.key}-${var.environment}"
  delay_seconds = each.value.delay
}
```

Apply — only `orders` and `billing` queues should be created.

**Deliverable:** Paste the queue names from `terraform output`.

---

## Task 5: Combined Conditionals

Build a complete config that demonstrates all three patterns:

1. **Ternary** in locals for naming and sizing
2. **Count** for optional resources (versioning, audit bucket)
3. **For expression** to filter a list of environments

The config should:
- Create different bucket names for prod vs non-prod
- Enable versioning only for non-prod
- Include an "audit" queue only when `var.environment == "prod"`
- Filter out disabled services from a map

**Deliverable:** Paste the full `locals.tf` and `terraform plan` output.

---

