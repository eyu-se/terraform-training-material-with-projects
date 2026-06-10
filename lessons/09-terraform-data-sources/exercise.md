# Exercise 09: Terraform Data Sources

## Prerequisites

- LocalStack running
- Terraform installed

## Task 1: Create Resources Manually via CLI

Before writing any Terraform, create these resources using the AWS CLI:

```bash
aws --endpoint-url=http://localhost:4566 s3 mb s3://manual-source-bucket
aws --endpoint-url=http://localhost:4566 s3api put-bucket-tagging \
  --bucket manual-source-bucket \
  --tagging 'TagSet=[{Key=Source,Value=CLI},{Key=Purpose,Value=DataSources}]'

aws --endpoint-url=http://localhost:4566 dynamodb create-table \
  --table-name ManualTable \
  --key-schema AttributeName=pk,KeyType=HASH \
  --attribute-definitions AttributeName=pk,AttributeType=S \
  --billing-mode PAY_PER_REQUEST
```

**Deliverable:** Paste the CLI output confirming both resources were created.

---

## Task 2: Read Resources with Data Sources

Create a directory `data-source-exercise`. Inside, create:

1. `provider.tf` — standard LocalStack AWS provider
2. `variables.tf` with:
   - `source_bucket` (string, no default — required)
   - `source_table` (string, no default — required)
3. `data.tf` with data sources for:
   - `aws_s3_bucket` named `source` using `var.source_bucket`
   - `aws_dynamodb_table` named `source` using `var.source_table`
   - `aws_caller_identity` named `current`
   - `aws_region` named `current`

Run `terraform plan` with the bucket and table names you created:

```bash
terraform plan \
  -var="source_bucket=manual-source-bucket" \
  -var="source_table=ManualTable"
```

**Deliverable:** Paste the `terraform plan` output showing the data sources being read.

---

## Task 3: Create an Outputs File

Create `outputs.tf` that outputs:

1. The ARN of the source bucket
2. The ARN of the source table
3. The table name
4. The current account ID
5. The current region name (use `data.aws_region.current.region`)

Apply and view the outputs.

**Deliverable:** Paste the `Outputs:` section.

---

## Task 4: Create a Resource that Uses Data Source Attributes

Create `main.tf` with:

1. An `aws_sqs_queue` named `"data-driven-queue"`
2. Its tags should include:
   - `SourceBucket` = the source bucket's ID
   - `SourceTable` = the source table's ARN
   - `AccountID` = the current account ID

Apply and verify the queue was created with the correct tags.

**Deliverable:** Paste `terraform state show aws_sqs_queue.driven` showing the tags.

---

## Task 5: Use `aws_iam_policy_document` Data Source

Create a data source for an IAM policy document that:

1. Allows `s3:GetObject` on the source bucket from any principal
2. Creates an `aws_s3_bucket_policy` resource that attaches this policy to the source bucket

Apply and verify the bucket policy exists.

**Deliverable:** Paste `terraform state show aws_s3_bucket_policy.main` and the CLI command to verify:

```bash
aws --endpoint-url=http://localhost:4566 s3api get-bucket-policy --bucket manual-source-bucket
```

---

