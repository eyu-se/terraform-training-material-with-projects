# Exercise 07: Terraform Outputs

## Prerequisites

- LocalStack running
- Terraform installed

## Task 1: Resources with Outputs

Create a directory `outputs-exercise`. Inside it create:

1. `provider.tf` — standard LocalStack AWS provider
2. `variables.tf` — with `environment` (string, default `"dev"`) and `project_name` (string, required)
3. `main.tf` — with `aws_s3_bucket`, `aws_dynamodb_table`, `aws_sqs_queue` using the variables
4. `terraform.tfvars` — set environment and project_name

Create an `outputs.tf` with these outputs:

| Output name | What it returns |
|-------------|-----------------|
| `bucket_name` | Bucket ID (name) |
| `bucket_arn` | Bucket ARN |
| `table_name` | DynamoDB table name |
| `table_arn` | DynamoDB table ARN |
| `queue_name` | SQS queue name from `terraform state show` |
| `queue_arn` | SQS queue ARN |
| `queue_url` | SQS queue URL |

Apply and verify the outputs display.

**Deliverable:** Paste the `Outputs:` section from `terraform apply`.

---

## Task 2: Query Outputs via CLI

Run these commands and note the results:

```bash
terraform output
terraform output bucket_arn
terraform output -json
terraform output -raw bucket_name
```

**Question:** What is the difference between `-raw` and the default output format?

---

## Task 3: Complex Outputs

Add these outputs to `outputs.tf`:

1. A combined output that lists all three ARNs in a map
2. An output that constructs a human-readable summary string
3. An output showing the bucket's region

Re-apply and view the outputs.

**Deliverable:** Paste the new outputs.

---

## Task 4: Sensitive Output

1. Create an input variable `db_password` with `sensitive = true`
2. Add an output `admin_password` that returns `var.db_password`
3. Set `admin_password` as `sensitive = true`
4. Add `db_password = "supersecret123"` to `terraform.tfvars`
5. Apply and observe the output shows `(sensitive value)`
6. Run `terraform output admin_password` — does it show the value?

**Deliverable:** Paste the output showing `(sensitive value)`.

---

## Task 5: Use Output in Script

Write a small bash script that:

1. Captures the bucket name using `terraform output -raw`
2. Creates a test file and uploads it to the bucket
3. Lists the bucket contents

```bash
#!/bin/bash
BUCKET=$(terraform output -raw bucket_name)
echo "test data" > /tmp/output-test.txt
aws --endpoint-url=http://localhost:4566 s3 cp /tmp/output-test.txt "s3://$BUCKET/"
aws --endpoint-url=http://localhost:4566 s3 ls "s3://$BUCKET/"
```

**Deliverable:** Paste the script output.

---

## Bonus Challenge

Destroy and re-create with `-auto-approve` flag:

```bash
terraform destroy -auto-approve
terraform apply -auto-approve
```

Then use `terraform output -json | jq` to extract the table ARN. If you don't have `jq`, use Python:

```bash
terraform output -json | python3 -c "import sys,json; print(json.load(sys.stdin)['table_arn']['value'])"
```
