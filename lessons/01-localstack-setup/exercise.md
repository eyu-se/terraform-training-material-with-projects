# Exercise 01: LocalStack Setup

## Task 1: Install and Verify

1. Start LocalStack using Docker
2. Verify the health endpoint returns `"available"` for S3, DynamoDB, SQS, Lambda, and IAM
3. Access the Web UI at `http://localhost:4566` (or `http://localhost.localstack.cloud:4566`)

**Deliverable:** Run the health check and paste the JSON output showing at least 5 services as `"available"`.

---

## Task 2: Create Resources from the Web UI

Using the LocalStack Web UI, create the following resources manually:

1. **S3 Bucket** named `training-bucket-[your-initials]`
2. **DynamoDB Table** named `Users` with:
   - Primary key: `userId` (String)
   - No sort key
3. **SQS Queue** named `notifications-queue`

**Deliverable:** Screenshot or text listing showing the three resources exist in the UI.

---

## Task 3: Document ARN Formats

Using the resources you created, note down the ARN (Amazon Resource Name) format for each:

1. S3 Bucket ARN
2. DynamoDB Table ARN
3. SQS Queue ARN

**Question:** What pattern do you notice about LocalStack ARNs compared to real AWS ARNs?

---

## Task 4: Service Support Research

Read the LocalStack documentation at https://docs.localstack.cloud and identify:

1. Three services that are fully supported in the free community edition
2. Three services that require the Pro edition
3. One service that is not supported at all

**Deliverable:** Create a small table in your own words.

---

## Bonus Challenge

Stop and restart your LocalStack container. Check if the S3 bucket, DynamoDB table, and SQS queue still exist after restart. Do they? Why or why not?
