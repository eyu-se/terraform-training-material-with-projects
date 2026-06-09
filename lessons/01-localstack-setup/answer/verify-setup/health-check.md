# Verify LocalStack Installation

Commands to verify LocalStack is working correctly.

## Check Container

```bash
docker ps
```

Look for `localstack/localstack` with status `Up`.

## Health Check

```bash
curl -s http://localhost:4566/_localstack/health | python3 -m json.tool
```

The response should include:
```json
{
    "services": {
        "s3": "available",
        "dynamodb": "available",
        "sqs": "available",
        "sns": "available",
        "lambda": "available",
        "iam": "available",
        "apigateway": "available",
        "cloudformation": "available"
    }
}
```

## Web UI

Open `http://localhost.localstack.cloud:4566` in your browser. You should see the LocalStack dashboard.
