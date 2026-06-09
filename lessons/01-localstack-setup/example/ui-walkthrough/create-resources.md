# UI Walkthrough — Create Resources Manually

This guide walks through creating S3, DynamoDB, and SQS resources via the LocalStack Web UI at `http://localhost.localstack.cloud:4566`.

## Create S3 Bucket

1. Click **S3** in the left sidebar under **Storage**
2. Click **Create Bucket**
3. Enter bucket name: `lesson-01-bucket`
4. Leave region as `us-east-1`
5. Click **Create**

After creation, click the bucket name to see the **ARN**:
```
arn:aws:s3:::lesson-01-bucket
```

## Create DynamoDB Table

1. Click **DynamoDB** in the left sidebar under **Database**
2. Click **Create Table**
3. Enter:
   - **Table name**: `LessonTable`
   - **Partition key**: `id`
   - **Key type**: `String`
4. Leave **Sort key** empty
5. Click **Create**

After creation, click the table name to see:
- **ARN**: `arn:aws:dynamodb:us-east-1:000000000000:table/LessonTable`
- **Table ID**: a UUID like `a1b2c3d4-e5f6-7890-abcd-ef1234567890`

## Create SQS Queue

1. Click **SQS** in the left sidebar under **App Integration**
2. Click **Create Queue**
3. Enter queue name: `lesson-queue`
4. Type: `Standard`
5. Click **Create**

After creation, click the queue to see:
- **ARN**: `arn:aws:sqs:us-east-1:000000000000:lesson-queue`
- **Queue URL**: `http://localhost:4566/000000000000/lesson-queue`

## ARN Pattern Summary

| Resource | ARN |
|----------|-----|
| S3 Bucket | `arn:aws:s3:::lesson-01-bucket` |
| DynamoDB Table | `arn:aws:dynamodb:us-east-1:000000000000:table/LessonTable` |
| SQS Queue | `arn:aws:sqs:us-east-1:000000000000:lesson-queue` |

LocalStack uses account ID `000000000000` instead of a real 12-digit AWS account number.
