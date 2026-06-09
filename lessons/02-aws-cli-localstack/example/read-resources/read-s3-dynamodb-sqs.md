# Read Resources via CLI

## List S3 Buckets

```bash
aws --endpoint-url=http://localhost:4566 s3 ls
```

## List S3 Objects

```bash
aws --endpoint-url=http://localhost:4566 s3 ls s3://cli-training-bucket/
```

## List DynamoDB Tables

```bash
aws --endpoint-url=http://localhost:4566 dynamodb list-tables
```

## Scan Table

```bash
aws --endpoint-url=http://localhost:4566 dynamodb scan --table-name TrainingTable
```

## List SQS Queues

```bash
aws --endpoint-url=http://localhost:4566 sqs list-queues
```

## Receive Messages

```bash
QUEUE_URL=$(aws --endpoint-url=http://localhost:4566 sqs list-queues --query 'QueueUrls[0]' --output text)
aws --endpoint-url=http://localhost:4566 sqs receive-message --queue-url $QUEUE_URL
```
