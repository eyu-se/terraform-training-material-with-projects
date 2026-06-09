# Create S3 Bucket via CLI

```bash
aws --endpoint-url=http://localhost:4566 s3 mb s3://cli-training-bucket
```

Verify:

```bash
aws --endpoint-url=http://localhost:4566 s3 ls
```

## Upload a File

```bash
echo "AWS CLI + LocalStack example" > example.txt
aws --endpoint-url=http://localhost:4566 s3 cp example.txt s3://cli-training-bucket/
```

Verify:

```bash
aws --endpoint-url=http://localhost:4566 s3 ls s3://cli-training-bucket/
```

## Create DynamoDB Table

```bash
aws --endpoint-url=http://localhost:4566 dynamodb create-table \
  --table-name TrainingTable \
  --key-schema AttributeName=pk,KeyType=HASH \
  --attribute-definitions AttributeName=pk,AttributeType=S \
  --billing-mode PAY_PER_REQUEST
```

## Insert Items

```bash
aws --endpoint-url=http://localhost:4566 dynamodb put-item \
  --table-name TrainingTable \
  --item '{"pk": {"S": "1"}, "name": {"S": "Alice"}, "role": {"S": "engineer"}}'

aws --endpoint-url=http://localhost:4566 dynamodb put-item \
  --table-name TrainingTable \
  --item '{"pk": {"S": "2"}, "name": {"S": "Bob"}, "role": {"S": "designer"}}'
```

## Create SQS Queue

```bash
QUEUE_URL=$(aws --endpoint-url=http://localhost:4566 sqs create-queue --queue-name training-queue --query 'QueueUrl' --output text)
echo $QUEUE_URL
```

## Send Messages

```bash
aws --endpoint-url=http://localhost:4566 sqs send-message \
  --queue-url $QUEUE_URL \
  --message-body "First message"

aws --endpoint-url=http://localhost:4566 sqs send-message \
  --queue-url $QUEUE_URL \
  --message-body "Second message"
```
