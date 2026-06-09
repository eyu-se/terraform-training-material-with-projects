# Document Storage — Usage Examples

This folder contains CLI commands to test the document storage system after deployment.

## Verify Infrastructure

```bash
aws --endpoint-url=http://localhost:4566 s3 ls
aws --endpoint-url=http://localhost:4566 dynamodb list-tables

aws --endpoint-url=http://localhost:4566 s3api get-bucket-versioning --bucket docstore-dev-documents
aws --endpoint-url=http://localhost:4566 s3api get-bucket-encryption --bucket docstore-dev-documents
aws --endpoint-url=http://localhost:4566 s3api get-public-access-block --bucket docstore-dev-documents

aws --endpoint-url=http://localhost:4566 dynamodb describe-table --table-name document-index-dev
```

## Upload Document and Metadata

```bash
echo "Document content for testing" > /tmp/sample-doc.txt

aws --endpoint-url=http://localhost:4566 s3 cp /tmp/sample-doc.txt s3://docstore-dev-documents/

aws --endpoint-url=http://localhost:4566 dynamodb put-item \
  --table-name document-index-dev \
  --item '{
    "document_id": {"S": "doc-001"},
    "filename": {"S": "sample-doc.txt"},
    "size_bytes": {"N": "30"},
    "content_type": {"S": "text/plain"},
    "upload_date": {"S": "2026-06-09"}
  }'
```

## Query Documents

```bash
# By document ID
aws --endpoint-url=http://localhost:4566 dynamodb get-item \
  --table-name document-index-dev \
  --key '{"document_id": {"S": "doc-001"}}'

# By filename (using GSI)
aws --endpoint-url=http://localhost:4566 dynamodb query \
  --table-name document-index-dev \
  --index-name filename-index \
  --key-condition-expression "filename = :f" \
  --expression-attribute-values '{":f": {"S": "sample-doc.txt"}}'
```
