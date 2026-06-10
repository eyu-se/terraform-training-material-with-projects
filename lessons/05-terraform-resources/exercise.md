# Exercise 05: Terraform Resources

## Prerequisites

- LocalStack running
- Terraform installed

## Task 1: Create an S3 Bucket with Versioning

Create a directory `resource-exercise`. In it, create:

1. `provider.tf` — standard LocalStack AWS provider config (include all skip flags, endpoints for s3, dynamodb, sqs)
2. `main.tf` with:
   - An `aws_s3_bucket` named `versioned-bucket-[your-initials]`
   - An `aws_s3_bucket_versioning` resource that enables versioning
   - An `aws_s3_bucket_server_side_encryption_configuration` resource using `AES256`

Apply and verify the bucket exists.

**Deliverable:** Paste the output of `terraform state show aws_s3_bucket.versioned`.

---

## Task 2: Create a DynamoDB Table with a GSI

Add to `main.tf`:

An `aws_dynamodb_table` named `Products` with:
- `hash_key`: `product_id` (String)
- `billing_mode`: `PAY_PER_REQUEST`
- A `global_secondary_index` named `category-index` with:
  - `hash_key`: `category`
  - `projection_type`: `ALL`
  - Add the `category` attribute definition

Apply and verify.

**Deliverable:** Paste the output of `terraform state show aws_dynamodb_table.products`.

---

## Task 3: Create an SQS Queue with Custom Settings

Add to `main.tf`:

An `aws_sqs_queue` named `event-queue` with:
- `delay_seconds`: `5`
- `message_retention_seconds`: `604800` (7 days)
- `receive_wait_time_seconds`: `10` (long polling)

Apply.

**Deliverable:** Paste the output of `terraform plan` showing `1 to add`.

---

## Task 4: Cross-Reference and Verify

1. Create an `outputs.tf` that outputs the ARN of each resource
2. Run `terraform apply` and confirm the outputs
3. Verify all resources via CLI and Web UI

**Question:** What is the SQS queue's `id` attribute — is it the name or the URL?

---

## Task 5: Destroy

```bash
terraform destroy
```

**Deliverable:** Paste the output.

---

## Bonus Challenge

Add an `aws_s3_bucket_policy` resource that grants your SQS queue permission to write to the S3 bucket. Use `data "aws_iam_policy_document"` to construct the JSON policy.

Hint: You'll need the SQS queue ARN from `aws_sqs_queue.event.arn`.
