# Exercise 13: Dynamic Blocks

## Prerequisites

- LocalStack running
- Terraform installed

## Task 1: Security Group with Dynamic Ingress

Create a directory `dynamic-exercise`. Create:

1. `provider.tf` — standard LocalStack AWS provider
2. `variables.tf` with:
   - `ingress_rules` — `list(object(...))` with `from_port`, `to_port`, `protocol`, `cidr_blocks`
   - Default rules: HTTP (80), HTTPS (443), SSH (22)
3. `main.tf` with `aws_security_group` named `"dynamic-sg"` and a `dynamic "ingress"` block

Apply and verify.

**Deliverable:** Paste `terraform state show aws_security_group.main` showing the 3 ingress rules.

---

## Task 2: Conditional Dynamic Block

Add a variable `enable_ssh` (bool, default `true`). Use a `local` to filter the rules:

```hcl
locals {
  rules = var.enable_ssh ? var.ingress_rules : [
    for r in var.ingress_rules : r if r.from_port != 22
  ]
}
```

Change the dynamic block to use `local.rules` instead of `var.ingress_rules`. Apply with both `true` and `false` for `enable_ssh`.

**Question:** How many ingress rules exist when `enable_ssh = false`?

---


---

## Task 3: S3 Bucket with Dynamic Logging

Add a conditional logging configuration to an S3 bucket:

1. Create a logging bucket: `aws_s3_bucket.logs`
2. Create a main bucket with a `dynamic "logging"` block that is enabled when `var.enable_logging = true`

```hcl
variable "enable_logging" {
  type    = bool
  default = true
}

resource "aws_s3_bucket" "logging" {
  bucket = "logging-target-bucket"
}

resource "aws_s3_bucket" "main" {
  bucket = "main-app-bucket"

  dynamic "logging" {
    for_each = var.enable_logging ? [1] : []
    content {
      target_bucket = aws_s3_bucket.logging.id
      target_prefix = "logs/"
    }
  }
}
```

Test with both `true` and `false`.

**Deliverable:** Paste the logging configuration from `terraform state show` when `enable_logging = true`.

---

## Task 4: Custom Iterator

Rewrite the ingress dynamic block using a custom iterator named `"rule"` instead of the default:

```hcl
dynamic "ingress" {
  for_each = local.rules
  iterator = rule
  content {
    from_port   = rule.value.from_port
    ...
  }
}
```

Verify it works the same way.

**Question:** When would using a custom iterator be helpful compared to the default?

---

