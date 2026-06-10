# Exercise 12: Count and for_each

## Prerequisites

- LocalStack running
- Terraform installed

## Task 1: Create Queues with `count`

Create a directory `count-exercise`. Create:

1. `provider.tf` — standard LocalStack config
2. `variables.tf` with:
   - `queue_names` — `list(string)` defaulting to `["alerts", "logs", "events"]`
3. `main.tf` with `aws_sqs_queue` using `count` and referencing `var.queue_names[count.index]`

Apply and verify.

**Deliverable:** Paste `terraform state list` output and run `aws --endpoint-url=http://localhost:4566 sqs list-queues`.

---

## Task 2: Output Queue Names

Create `outputs.tf` with:

```hcl
output "queue_names" {
  value = aws_sqs_queue.main[*].name
}
```

Apply and view the output.

**Question:** What format does `[*]` return?

---

## Task 3: Create Buckets with `for_each`

Add to your config:

```hcl
variable "buckets" {
  type = map(string)
  default = {
    data   = "us-east-1"
    logs   = "us-east-1"
    backup = "us-east-1"
  }
}

resource "aws_s3_bucket" "main" {
  for_each = var.buckets
  bucket   = "bucket-${each.key}"
}
```

Apply. Note the addresses in `terraform state list` — they use key names, not indices.

**Deliverable:** Paste `terraform state list` output showing `["data"]`, `["logs"]`, `["backup"]`.

---

## Task 4: Conditional Count

Add a variable `create_audit_bucket` (bool, default `false`). Create a conditional S3 bucket:

```hcl
resource "aws_s3_bucket" "audit" {
  count  = var.create_audit_bucket ? 1 : 0
  bucket = "audit-bucket"
}
```

Apply with `var.create_audit_bucket = true`, then apply with `false`. Observe the state.

**Question:** When `count = 0`, does the resource appear in `terraform state list`?

---

## Task 5: Remove Middle Items

Test the difference between `count` and `for_each`:

1. **With count:** Change `queue_names` from `["a", "b", "c"]` to `["a", "c"]`. Run `terraform plan` — note what happens to `b` and `c`.
2. **With for_each:** Change the `buckets` map to remove `"logs"`. Run `terraform plan` — note only `logs` is affected.

**Question:** Why does removing "b" from a count list cause "c" to show as destroyed + recreated?

---

## Bonus Challenge

Create a DynamoDB table with `for_each` where each table has different read/write capacity:

```hcl
variable "tables" {
  type = map(object({
    write_capacity = number
    read_capacity  = number
  }))
}
```

Hint: Look up `aws_dynamodb_table` attributes for provisioned billing mode (set `billing_mode = "PROVISIONED"`).
