# Exercise 10: State Management

## Prerequisites

- LocalStack running
- Terraform installed

## Task 1: Create Resources and Inspect State

1. Create a directory `state-exercise`
2. Create `provider.tf` (standard LocalStack config), `main.tf` with an S3 bucket, DynamoDB table, and SQS queue
3. Apply the config

Run these commands and note outputs:

```bash
terraform state list
terraform state show aws_s3_bucket.main
terraform state pull | python3 -m json.tool | head -30
```

**Deliverable:** Paste `terraform state list` output.

---

## Task 2: Examine the Raw State File

```bash
cat terraform.tfstate | python3 -m json.tool
```

Look at the JSON structure and identify:

1. The `terraform_version` field
2. The `serial` field — what happens to it after each apply?
3. The `backend` section
4. One resource's full attributes

**Question:** What is the `serial` field and when does it increment?

---

## Task 3: Remove a Resource from State

Remove the SQS queue from state (without destroying the real resource):

```bash
terraform state rm aws_sqs_queue.main
```

Verify:

```bash
terraform state list
# Should show only S3 and DynamoDB
```

Now run:

```bash
terraform plan
```

**Question:** What does `terraform plan` show for the SQS queue now? Why does it want to create a duplicate?

Clean up by deleting the queue from LocalStack:

```bash
aws --endpoint-url=http://localhost:4566 sqs delete-queue \
  --queue-url $(aws --endpoint-url=http://localhost:4566 sqs list-queues --query 'QueueUrls[0]' --output text)
```

---

## Task 4: Rename a Resource and Move State

1. Edit `main.tf` — rename the S3 bucket resource from `"main"` to `"storage"`
2. Run `terraform plan` — notice it wants to **destroy** the old and **create** a new one
3. Instead of applying, fix it with state mv:
   ```bash
   terraform state mv aws_s3_bucket.main aws_s3_bucket.storage
   ```
4. Run `terraform plan` again — it should show **no changes**

**Deliverable:** Paste the `terraform plan` output before and after the `state mv`.

---

## Task 5: Re-add Queue to State via Import

You'll need to import the SQS queue back into state (if you destroyed it in Task 3, create a new one first):

```bash
# Create a queue if needed
aws --endpoint-url=http://localhost:4566 sqs create-queue --queue-name exercise-queue

# Get its URL and ARN
QUEUE_URL=$(aws --endpoint-url=http://localhost:4566 sqs list-queues --query 'QueueUrls[0]' --output text)
echo $QUEUE_URL
```

Re-add the queue resource to your `main.tf` and import it:

```bash
terraform import aws_sqs_queue.main $QUEUE_URL
```

Verify with `terraform state list`.

**Deliverable:** Paste the output of `terraform import`.

---

## Bonus Challenge

Use `terraform state pull` to export the full state, then use `jq` to count resources:

```bash
terraform state pull | jq '.resources | length'
```

Or without jq:

```bash
terraform state pull | python3 -c "import sys,json; print(len(json.load(sys.stdin)['resources']))"
```

Then test `terraform state push` by modifying the exported JSON (change a tag value) and pushing it back. What happens?
