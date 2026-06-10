# Exercise 11: Dependencies

## Prerequisites

- LocalStack running
- Terraform installed
- Graphviz (optional, for bonus): `brew install graphviz`

## Task 1: Create Resources with Implicit Dependencies

Create a directory `deps-exercise`. Create:

1. `provider.tf` — standard LocalStack config
2. `main.tf` with:
   - `aws_s3_bucket` named `"deps-bucket"`
   - `aws_s3_bucket_versioning` referencing `aws_s3_bucket.deps.id` (implicit dependency)
   - `aws_s3_bucket_public_access_block` referencing `aws_s3_bucket.deps.id`
   - `aws_sqs_queue` named `"deps-queue"` with **no** dependency on the bucket

Apply and verify all are created.

**Deliverable:** Paste the plan output — in what order are resources displayed?

---

## Task 2: Add an Explicit Dependency

Add `depends_on` to the SQS queue so it must be created **after** the S3 bucket:

```hcl
depends_on = [aws_s3_bucket.deps]
```

Re-run `terraform plan` — does the order change?

**Question:** Why might you need `depends_on` even though the queue doesn't reference the bucket directly?

---

## Task 3: Chain Dependencies

Add an `aws_dynamodb_table` named `"deps-table"` that depends on **both** the bucket and the queue:

```hcl
depends_on = [
  aws_s3_bucket.deps,
  aws_sqs_queue.deps,
]
```

Apply. Then run `terraform state list` and note the order.

**Deliverable:** Paste `terraform state list` output.

---

## Task 4: Visualize with `terraform graph`

```bash
terraform graph
```

This prints the dependency graph in DOT format. If you have Graphviz:

```bash
terraform graph | dot -Tpng > deps-graph.png
open deps-graph.png
```

**Question:** Look at the graph. Which edges are from implicit references and which from explicit `depends_on`?

---

## Task 5: Test Removal of a Dependency

1. Remove `depends_on` from the DynamoDB table
2. Add a direct reference instead: use `aws_sqs_queue.deps.arn` as a tag value on the table
3. Run `terraform plan` — does Terraform still order correctly?

```hcl
resource "aws_dynamodb_table" "deps" {
  name         = "deps-table"
  billing_mode = "PAY_PER_REQUEST"
  hash_key     = "pk"

  attribute {
    name = "pk"
    type = "S"
  }

  tags = {
    QueueArn = aws_sqs_queue.deps.arn  # <-- implicit dependency
  }
}
```

**Deliverable:** Paste the plan output showing the DynamoDB table is created after the queue.

---

## Bonus Challenge

Create a circular dependency intentionally and capture the error:

```hcl
resource "aws_sqs_queue" "a" {
  name       = "circular-a"
  depends_on = [aws_sqs_queue.b]
}

resource "aws_sqs_queue" "b" {
  name       = "circular-b"
  depends_on = [aws_sqs_queue.a]
}
```

What error does Terraform produce?
