# Exercise 18: Document Storage System

## Prerequisites

- LocalStack running
- Terraform installed

## Task 1: Create the Module Structure

Create this directory structure:

```
document-storage/
├── main.tf
├── provider.tf
├── variables.tf
├── locals.tf
├── outputs.tf
├── modules/
│   ├── document-bucket/
│   │   ├── main.tf
│   │   ├── variables.tf
│   │   └── outputs.tf
│   └── document-index/
│       ├── main.tf
│       ├── variables.tf
│       └── outputs.tf
```

Create both modules following the patterns from the lesson.

**Deliverable:** List all files in the project.

---

## Task 2: Deploy the Infrastructure

Apply the root configuration:

```bash
terraform init
terraform apply
```

**Deliverable:** Paste `terraform output` showing bucket and table names.

---

## Task 3: Verify Security Config

Verify that the bucket has the correct security settings:

```bash
aws --endpoint-url=http://localhost:4566 s3api get-bucket-versioning --bucket <bucket-name>
aws --endpoint-url=http://localhost:4566 s3api get-bucket-encryption --bucket <bucket-name>
aws --endpoint-url=http://localhost:4566 s3api get-public-access-block --bucket <bucket-name>
```

**Deliverable:** Paste the outputs of all three commands.

---

## Task 4: Create Document and Metadata

Upload a document and create its metadata entry:

```bash
echo "Exercise document content" > /tmp/exercise-doc.txt
aws --endpoint-url=http://localhost:4566 s3 cp /tmp/exercise-doc.txt s3://<bucket-name>/

aws --endpoint-url=http://localhost:4566 dynamodb put-item \
  --table-name document-index-dev \
  --item '{
    "document_id": {"S": "doc-ex-001"},
    "filename": {"S": "exercise-doc.txt"},
    "size_bytes": {"N": "27"},
    "content_type": {"S": "text/plain"},
    "upload_date": {"S": "2026-06-09"}
  }'
```

**Deliverable:** Paste the S3 upload and DynamoDB put-item outputs.

---

## Task 5: Query Documents

Query by document ID:

```bash
aws --endpoint-url=http://localhost:4566 dynamodb get-item \
  --table-name document-index-dev \
  --key '{"document_id": {"S": "doc-ex-001"}}'
```

Query by filename (using GSI):

```bash
aws --endpoint-url=http://localhost:4566 dynamodb query \
  --table-name document-index-dev \
  --index-name filename-index \
  --key-condition-expression "filename = :f" \
  --expression-attribute-values '{":f": {"S": "exercise-doc.txt"}}'
```

**Deliverable:** Paste both query outputs.

---

## Bonus Challenge

Add a second GSI to the DynamoDB table for `content_type` to enable querying documents by type. Then apply and verify:

```bash
aws --endpoint-url=http://localhost:4566 dynamodb query \
  --table-name document-index-dev \
  --index-name content-type-index \
  --key-condition-expression "content_type = :ct" \
  --expression-attribute-values '{":ct": {"S": "text/plain"}}'
```
