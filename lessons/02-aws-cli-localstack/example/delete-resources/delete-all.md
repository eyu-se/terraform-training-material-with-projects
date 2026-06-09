# Delete Resources via CLI

```bash
# Delete S3 object and bucket
aws --endpoint-url=http://localhost:4566 s3 rm s3://cli-training-bucket/example.txt
aws --endpoint-url=http://localhost:4566 s3 rb s3://cli-training-bucket

# Delete DynamoDB table
aws --endpoint-url=http://localhost:4566 dynamodb delete-table --table-name TrainingTable

# Delete SQS queue
QUEUE_URL=$(aws --endpoint-url=http://localhost:4566 sqs list-queues --query 'QueueUrls[0]' --output text)
aws --endpoint-url=http://localhost:4566 sqs delete-queue --queue-url $QUEUE_URL
```

## Verify Cleanup

```bash
aws --endpoint-url=http://localhost:4566 s3 ls
aws --endpoint-url=http://localhost:4566 dynamodb list-tables
aws --endpoint-url=http://localhost:4566 sqs list-queues
```

All three should return empty.
