# Docker Compose — LocalStack Setup

Use this file to start LocalStack with Docker Compose.

## Usage

```bash
# Set your auth token
export LOCALSTACK_AUTH_TOKEN="ls-xxxx-xxxx-xxxx-xxxx"

# Start LocalStack
docker compose up -d

# Check logs
docker compose logs -f
```

## Health Check

```bash
curl -s http://localhost:4566/_localstack/health | python3 -m json.tool
```

All services should show `"available"`.
