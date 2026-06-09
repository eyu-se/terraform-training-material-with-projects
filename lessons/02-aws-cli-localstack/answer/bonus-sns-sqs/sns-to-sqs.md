# Bonus — SNS Topic with SQS Subscription

## Create SNS Topic

```bash
TOPIC_ARN=$(aws --endpoint-url=http://localhost:4566 sns create-topic --name alert-topic --query 'TopicArn' --output text)
echo $TOPIC_ARN
```

## Subscribe SQS Queue to SNS Topic

```bash
QUEUE_ARN="arn:aws:sqs:us-east-1:000000000000:alerts-queue"

aws --endpoint-url=http://localhost:4566 sns subscribe \
  --topic-arn $TOPIC_ARN \
  --protocol sqs \
  --notification-endpoint $QUEUE_ARN
```

## Publish a Message to SNS

```bash
aws --endpoint-url=http://localhost:4566 sns publish \
  --topic-arn $TOPIC_ARN \
  --message "Hello from SNS to SQS"
```

## Receive from Queue

```bash
aws --endpoint-url=http://localhost:4566 sqs receive-message \
  --queue-url http://localhost:4566/000000000000/alerts-queue
```

The message body will contain the SNS envelope wrapping your published message.
