# Exercise 04: Terraform AWS Provider

## Prerequisites

- LocalStack running
- Terraform installed

## Task 1: Configure AWS Provider

1. Create a directory named `terraform-aws-exercise`
2. Create `provider.tf` with the AWS provider configured for LocalStack (all skip flags, endpoints for s3, dynamodb, sqs)
3. Run `terraform init`

**Deliverable:** Paste the output of `terraform init` showing the AWS provider was downloaded.

---

## Task 2: Create an S3 Bucket

1. Create `main.tf` with an `aws_s3_bucket` resource named `exercise-bucket-04`
2. Run `terraform fmt` and `terraform validate`
3. Run `terraform plan`
4. Run `terraform apply`

**Deliverable:** Paste the output of `terraform plan`.

---

## Task 3: Add DynamoDB Table and SQS Queue

Add to `main.tf`:

1. An `aws_dynamodb_table` named `ExerciseTable` with:
   - `hash_key` = `"pk"`
   - `billing_mode` = `"PAY_PER_REQUEST"`
   - String attribute `"pk"`
2. An `aws_sqs_queue` named `exercise-queue`

Apply the changes.

**Deliverable:** Paste the output of `terraform plan` showing `2 to add`.

---

## Task 4: Verify in CLI and Web UI

1. Use AWS CLI to list the bucket, table, queue
2. Open LocalStack Web UI and verify all three resources exist

**Deliverable:** Paste the CLI output and the ARNs of each resource.

---

## Task 5: Destroy Everything

```bash
terraform destroy
```

**Deliverable:** Paste the final output showing `Resources: 0 destroyed` (meaning nothing was destroyed since everything was already cleaned up).

---

## Bonus Challenge

Add an `aws_sns_topic` resource to your config and create it with `terraform apply`. Then use the AWS CLI to subscribe your SQS queue to the SNS topic.

Hint: You'll need the SQS queue ARN. You can get it from `terraform state show aws_sqs_queue.exercise`.
