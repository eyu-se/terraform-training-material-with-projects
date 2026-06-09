# Exercise 02: AWS CLI with LocalStack

## Task 1: Install and Verify

1. Install AWS CLI (if not already installed)
2. Run `aws --version` and note the version
3. Run `aws configure` with `test`/`test`/`us-east-1`/`json`
4. Verify the config files exist:
   ```bash
   cat ~/.aws/credentials
   cat ~/.aws/config
   ```

**Deliverable:** Paste the output of `aws --version`.

---

## Task 2: Create Resources via CLI

Create each of the following using `aws --endpoint-url=http://localhost:4566`:

1. **S3 Bucket** named `cli-training-[your-initials]`
2. Upload a file named `notes.txt` with your name inside it
3. **DynamoDB Table** named `Employees` with:
   - Partition key: `employeeId` (String)
   - Billing mode: PAY_PER_REQUEST
4. Insert 3 items into the `Employees` table with fields: `employeeId`, `name`, `department`
5. **SQS Queue** named `alerts-queue`
6. Send 2 messages to the queue

**Deliverable:** Paste the commands you used and their JSON outputs.

---

## Task 3: Read Resources via CLI

Use CLI commands to read back the resources you created:

1. List all S3 buckets
2. List objects in your bucket
3. List all DynamoDB tables
4. Scan the `Employees` table
5. List all SQS queues
6. Receive one message from `alerts-queue`

**Deliverable:** Paste the commands and outputs.

---

## Task 4: Verify in the Web UI

Open the LocalStack Web UI and navigate to:
- S3 — verify bucket and file exist
- DynamoDB — verify `Employees` table and its 3 items
- SQS — verify `alerts-queue` exists

**Question:** Do the ARNs shown in the Web UI match the CLI output? Paste one ARN from each service.

---

## Task 5: Delete Resources via CLI

Delete all resources you created:

1. Delete the S3 object and bucket
2. Delete the DynamoDB table
3. Delete the SQS queue

Then run list commands to confirm they are gone.

**Deliverable:** Paste the commands and final list outputs (which should be empty).

---

## Bonus Challenge
SNS : https://aws.amazon.com/sns/
Try creating an **SNS Topic** using the CLI:

```bash
aws --endpoint-url=http://localhost:4566 sns create-topic --name alert-topic
```

Then subscribe your SQS queue to the SNS topic and publish a message. Verify the message arrives in the queue.
