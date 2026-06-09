# ARN Formats — Reference

Expected ARNs for resources created in the Web UI.

| Resource | ARN |
|----------|-----|
| S3 Bucket | `arn:aws:s3:::lesson-01-bucket` |
| DynamoDB Table | `arn:aws:dynamodb:us-east-1:000000000000:table/LessonTable` |
| SQS Queue | `arn:aws:sqs:us-east-1:000000000000:lesson-queue` |

The account number `000000000000` is LocalStack's default. On real AWS this would be a 12-digit number unique to your account.

Resources persist across container restarts (`docker stop`/`docker start`) but are deleted when the container is removed (`docker rm`).
