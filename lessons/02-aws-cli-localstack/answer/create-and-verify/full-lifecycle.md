# Solution — Create and Verify

Complete sequence for the exercise.

## 1. Verify AWS CLI

```bash
aws --version
```

## 2. Create S3 Bucket

```bash
aws --endpoint-url=http://localhost:4566 s3 mb s3://cli-training-eyu
echo "My name is Eyu" > notes.txt
aws --endpoint-url=http://localhost:4566 s3 cp notes.txt s3://cli-training-eyu/
```

## 3. Create DynamoDB Table

```bash
aws --endpoint-url=http://localhost:4566 dynamodb create-table \
  --table-name Employees \
  --key-schema AttributeName=employeeId,KeyType=HASH \
  --attribute-definitions AttributeName=employeeId,AttributeType=S \
  --billing-mode PAY_PER_REQUEST

# Insert 3 items
aws --endpoint-url=http://localhost:4566 dynamodb put-item \
  --table-name Employees \
  --item '{"employeeId": {"S": "1"}, "name": {"S": "Alice"}, "department": {"S": "Engineering"}}'

aws --endpoint-url=http://localhost:4566 dynamodb put-item \
  --table-name Employees \
  --item '{"employeeId": {"S": "2"}, "name": {"S": "Bob"}, "department": {"S": "Design"}}'

aws --endpoint-url=http://localhost:4566 dynamodb put-item \
  --table-name Employees \
  --item '{"employeeId": {"S": "3"}, "name": {"S": "Carol"}, "department": {"S": "Marketing"}}'
```

## 4. Create SQS Queue and Send Messages

```bash
QUEUE_URL=$(aws --endpoint-url=http://localhost:4566 sqs create-queue --queue-name alerts-queue --query 'QueueUrl' --output text)

aws --endpoint-url=http://localhost:4566 sqs send-message --queue-url $QUEUE_URL --message-body "Alert: CPU usage high"
aws --endpoint-url=http://localhost:4566 sqs send-message --queue-url $QUEUE_URL --message-body "Alert: Memory usage high"
```

## 5. Read Back

```bash
aws --endpoint-url=http://localhost:4566 s3 ls
aws --endpoint-url=http://localhost:4566 dynamodb list-tables
aws --endpoint-url=http://localhost:4566 dynamodb scan --table-name Employees
aws --endpoint-url=http://localhost:4566 sqs list-queues
aws --endpoint-url=http://localhost:4566 sqs receive-message --queue-url $QUEUE_URL
```

## 6. Delete Everything

```bash
aws --endpoint-url=http://localhost:4566 s3 rm s3://cli-training-eyu/notes.txt
aws --endpoint-url=http://localhost:4566 s3 rb s3://cli-training-eyu
aws --endpoint-url=http://localhost:4566 dynamodb delete-table --table-name Employees
aws --endpoint-url=http://localhost:4566 sqs delete-queue --queue-url $QUEUE_URL
aws --endpoint-url=http://localhost:4566 s3 ls
aws --endpoint-url=http://localhost:4566 dynamodb list-tables
aws --endpoint-url=http://localhost:4566 sqs list-queues
```
