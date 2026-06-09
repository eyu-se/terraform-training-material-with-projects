# Lesson 02: AWS CLI with LocalStack

## Learning Objectives

- Install and configure the AWS CLI
- Configure AWS CLI to work with LocalStack
- Create, list, and delete AWS resources using the CLI
- Understand the `--endpoint-url` pattern
- Verify resources in both CLI and LocalStack Web UI

---

## 1. What is the AWS CLI?

The AWS Command Line Interface (CLI) is a unified tool to manage AWS services from the terminal. Instead of clicking through a web UI, you issue commands like:

```bash
aws s3 ls
aws dynamodb list-tables
aws sqs list-queues
```

**Key insight for this course:** We will always use the standard `aws` CLI with the `--endpoint-url` flag pointed at LocalStack. This is the same tool you'd use against real AWS — no special wrappers.

---

## 2. Install AWS CLI

### macOS

```bash
# Using Homebrew
brew install awscli

# Or using the official installer
curl "https://awscli.amazonaws.com/AWSCLIV2.pkg" -o "AWSCLIV2.pkg"
sudo installer -pkg AWSCLIV2.pkg -target /
```

### Linux (Debian/Ubuntu)

```bash
curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip"
unzip awscliv2.zip
sudo ./aws/install
```

### Windows

Download the installer from:
[https://awscli.amazonaws.com/AWSCLIV2.msi](https://awscli.amazonaws.com/AWSCLIV2.msi)

### Verify Installation

```bash
aws --version
```

Expected output: `aws-cli/2.x.x ...`

---

## 3. Configure AWS CLI for LocalStack

AWS CLI stores credentials and region in `~/.aws/config` and `~/.aws/credentials`. LocalStack accepts any credentials — we use dummy values.

```bash
aws configure
```

Enter the following when prompted:

```
AWS Access Key ID [None]: test
AWS Secret Access Key [None]: test
Default region name [None]: us-east-1
Default output format [None]: json
```

This creates two files:

**`~/.aws/credentials`**:
```ini
[default]
aws_access_key_id = test
aws_secret_access_key = test
```

**`~/.aws/config`**:
```ini
[default]
region = us-east-1
output = json
```

> **Why `test`/`test`?** LocalStack doesn't validate credentials. Any value works. Real AWS would require valid credentials from the IAM service.

---

## 4. The `--endpoint-url` Pattern

By default, `aws` CLI commands connect to the real AWS service endpoints (e.g., `s3.amazonaws.com`). To point them at LocalStack, add:

```bash
--endpoint-url=http://localhost:4566
```

Every command in this course follows this pattern:

```bash
aws --endpoint-url=http://localhost:4566 <service> <command>
```

### Creating an Alias (Optional)

To save typing, some developers create an alias:

```bash
alias awslocal='aws --endpoint-url=http://localhost:4566'
```

Then use:

```bash
awslocal s3 ls
```

**However**, for this course we will write the full `--endpoint-url` in documentation so you see the complete pattern. You may use the alias in your own terminal.

---

## 5. Managing Resources via CLI

Make sure LocalStack is running:

```bash
docker ps | grep localstack
```

### S3 — Create a Bucket

```bash
aws --endpoint-url=http://localhost:4566 s3 mb s3://cli-bucket
```

Expected output:

```
make_bucket: cli-bucket
```

List buckets:

```bash
aws --endpoint-url=http://localhost:4566 s3 ls
```

Upload a file:

```bash
echo "hello from cli" > sample.txt
aws --endpoint-url=http://localhost:4566 s3 cp sample.txt s3://cli-bucket/
```

List objects:

```bash
aws --endpoint-url=http://localhost:4566 s3 ls s3://cli-bucket/
```

### DynamoDB — Create a Table

```bash
aws --endpoint-url=http://localhost:4566 dynamodb create-table \
  --table-name CliTable \
  --key-schema AttributeName=id,KeyType=HASH \
  --attribute-definitions AttributeName=id,AttributeType=S \
  --billing-mode PAY_PER_REQUEST
```

List tables:

```bash
aws --endpoint-url=http://localhost:4566 dynamodb list-tables
```

Put an item:

```bash
aws --endpoint-url=http://localhost:4566 dynamodb put-item \
  --table-name CliTable \
  --item '{"id": {"S": "1"}, "name": {"S": "Alice"}, "role": {"S": "engineer"}}'
```

Scan the table:

```bash
aws --endpoint-url=http://localhost:4566 dynamodb scan \
  --table-name CliTable
```
q
### SQS — Create a Queue

```bash
aws --endpoint-url=http://localhost:4566 sqs create-queue \
  --queue-name cli-queue
```

Expected output:

```json
{
    "QueueUrl": "http://sqs.us-east-1.localhost.localstack.cloud:4566/000000000000/cli-queue"
}
```

List queues:

```bash
aws --endpoint-url=http://localhost:4566 sqs list-queues
```

Send a message:

```bash
aws --endpoint-url=http://localhost:4566 sqs send-message \
  --queue-url http://sqs.us-east-1.localhost.localstack.cloud:4566/000000000000/cli-queue \
  --message-body "Hello from CLI"
```

Receive a message:

```bash
aws --endpoint-url=http://localhost:4566 sqs receive-message \
  --queue-url http://sqs.us-east-1.localhost.localstack.cloud:4566/000000000000/cli-queue
```

---

## 6. Deleting Resources

### S3 — Delete Objects and Bucket

```bash
aws --endpoint-url=http://localhost:4566 s3 rm s3://cli-bucket/sample.txt
aws --endpoint-url=http://localhost:4566 s3 rb s3://cli-bucket
```

### DynamoDB — Delete Table

```bash
aws --endpoint-url=http://localhost:4566 dynamodb delete-table \
  --table-name CliTable
```

### SQS — Delete Queue

```bash
aws --endpoint-url=http://localhost:4566 sqs delete-queue \
  --queue-url http://sqs.us-east-1.localhost.localstack.cloud:4566/000000000000/cli-queue
```

---

## 7. Verifying in the Web UI

After creating resources via CLI, open the LocalStack Web UI at:

```
http://localhost.localstack.cloud:4566
```

Navigate to each service:

| Service | What to verify |
|---------|---------------|
| **S3** | Bucket `cli-bucket` appears, `sample.txt` listed inside |
| **DynamoDB** | Table `CliTable` appears with status `ACTIVE`, item count `1` |
| **SQS** | Queue `cli-queue` appears with URL matching CLI output |

This confirms that CLI-created resources are visible to the Web UI and vice versa — they share the same LocalStack instance.

---

## 8. Key Takeaways

- `--endpoint-url=http://localhost:4566` is the universal pattern for using AWS CLI with LocalStack
- The same CLI commands work against real AWS — only the endpoint changes
- All three services (S3, DynamoDB, SQS) have identical CLI APIs to real AWS
- Resources created via CLI are immediately visible in the Web UI
- The alias `awslocal` is optional; we use the full command for clarity
