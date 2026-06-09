# Lesson 01: LocalStack Setup

## Learning Objectives

- Understand what LocalStack is and why it exists
- Install and run LocalStack via Docker
- Verify the installation is working
- Explore the LocalStack Web UI
- Understand the service support matrix (free vs pro)

---

## 1. What is LocalStack?

LocalStack is a fully functional local AWS cloud stack. It emulates AWS services on your local machine so you can develop and test cloud applications **without an internet connection** and **without incurring AWS costs**.

### Why use LocalStack for learning Terraform?

- **No AWS account needed** — zero cost, no credit card required
- **Fast feedback loop** — resources create in milliseconds
- **Safe experimentation** — no risk of accidental production charges
- **Offline capable** — develop anywhere
- **Real AWS compatibility** — skills transfer directly to production

---

## 2. LocalStack Architecture

```
Your Machine
│
├── Docker Container (localstack/localstack)
│   │
│   ├── S3  ──► http://localhost:4566
│   ├── DynamoDB ──► http://localhost:4566
│   ├── Lambda ──► http://localhost:4566
│   ├── SQS ──► http://localhost:4566
│   ├── SNS ──► http://localhost:4566
│   ├── API Gateway ──► http://localhost:4566
│   ├── IAM ──► http://localhost:4566
│   ├── CloudFormation ──► http://localhost:4566
│   └── 40+ other services
│
├── Web UI ──► https://app.localstack.cloud/
└── API ──► http://localhost:4566
```

All AWS services are accessed through a **single endpoint**:

```
http://localhost:4566
```

---

## 3. Installation

> **Note on LocalStack versions:**
> As of 2025, the `localstack/localstack:latest` Docker image defaults to the **Pro** edition, which requires an auth token. The free **Community** edition (`:3.0.0` or later pinned tags) does not require a token but still benefits from having one for Web UI access.
>
> All lessons in this curriculum use only **free/Community features**. You have two installation options below.

### Prerequisites

- Docker installed on your machine
- Docker daemon running

Verify Docker:

```bash
docker --version
docker info
```

---

### Option 1: LocalStack Desktop App (Recommended for Beginners)

LocalStack provides a native desktop application with a built-in Docker manager, Web UI launcher, and one-click startup. This is the easiest way to get started.

1. Go to [https://docs.localstack.cloud/getting-started/installation/#desktop-app](https://docs.localstack.cloud/getting-started/installation/#desktop-app)
2. Download the installer for your OS:
   - **macOS**: `.dmg` file
   - **Windows**: `.exe` installer
   - **Linux**: `.AppImage` or `.deb`/`.rpm`
3. Install and launch the app
4. On first launch:
   - You'll be prompted to sign in to your LocalStack account (create one if you haven't already)
   - Go to **Settings → Auth Token** and paste your token (see "Get a LocalStack Auth Token" below)
5. Click **"Start LocalStack"** — the app handles Docker pulling, port mapping, and startup automatically
6. The Web UI opens at `http://localhost.localstack.cloud:4566` once ready

The Desktop App is ideal for visual learners. You can always switch to the Docker CLI approach later.

---

### Option 2: Official LocalStack CLI Installation

Follow the official CLI installation guide:

[https://docs.localstack.cloud/getting-started/installation/](https://docs.localstack.cloud/getting-started/installation/)

This covers `pip install localstack`, Homebrew on macOS, and other package managers.

---

### Option 3: Docker Installation (Most Common)

### Option 3: Docker Installation

#### Step 1: Get a LocalStack Auth Token

LocalStack uses auth tokens to unlock the Web UI and Pro features. The free tier is available with a token:

1. Go to [https://app.localstack.cloud](https://app.localstack.cloud)
2. Sign up for a free account (email or GitHub login)
3. After logging in, navigate to your **Auth Tokens** page:
   - Click your profile icon (top-right)
   - Select **"Auth Tokens"** from the dropdown
4. Click **"Generate Token"**
5. Copy the token — it looks like: `ls-xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx`

Keep this token handy. You'll use it in the `docker run` command as `LOCALSTACK_AUTH_TOKEN`.

#### Step 2: Run LocalStack

```bash
docker run \
-d \
--name localstack \
-p 4566:4566 \
-p 4510-4559:4510-4559 \
-e LOCALSTACK_AUTH_TOKEN=<your-token> \
localstack/localstack
```

**Flag explanation:**

| Flag | Purpose |
|------|---------|
| `-d` | Detached mode (runs in background) |
| `--name localstack` | Container name for easy reference |
| `-p 4566:4566` | Main API endpoint |
| `-p 4510-4559:4510-4559` | Service-specific endpoints (Lambda, etc.) |
| `-e LOCALSTACK_AUTH_TOKEN` | Your auth token from Step 1 |

### Verify the Container is Running

```bash
docker ps
```

Expected output includes a line with `localstack/localstack` and status `Up`.

You can also check logs:

```bash
docker logs localstack
```

---

## 4. Verify the Installation

### Health Check

```bash
curl -s http://localhost:4566/_localstack/health | python3 -m json.tool
```

Expected JSON response shows all services with `"available"` status:

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
        "cloudformation": "available",
        ...
    }
}
```

### Check the Web UI

Open in your browser:

```
http://localhost.localstack.cloud:4566
```

You should see the LocalStack Web UI with a navigation panel listing available services.

---

## 5. Exploring the Web UI

Navigate through these services in the UI to familiarize yourself:

| Service | What to look for |
|---------|-----------------|
| **S3** | Bucket listing, create bucket button |
| **Lambda** | Function listing, create function form |
| **DynamoDB** | Table listing, create table form |
| **SQS** | Queue listing, create queue form |
| **SNS** | Topic listing, create topic form |
| **IAM** | Users, roles, policies |
| **CloudFormation** | Stack management |

**Observation exercise:** Try creating resources manually from the UI:

1. Create an S3 bucket named `lesson-01-bucket`
2. Create a DynamoDB table named `LessonTable` with a primary key `id` (String)
3. Create an SQS queue named `lesson-queue`

Note the ARN format and resource IDs that LocalStack auto-generates.

---

## 6. Service Support Matrix

LocalStack offers different tiers. For this curriculum, the **free/community edition** is sufficient.

### Free Tier (Community)

| Fully Supported | Notes |
|-----------------|-------|
| S3 | Object storage |
| DynamoDB | NoSQL database |
| SQS | Message queues |
| SNS | Pub/sub notifications |
| Lambda | Serverless functions |
| IAM | Identity and access |
| CloudFormation | Infrastructure as code |
| API Gateway | REST APIs |
| CloudWatch Logs | Log management (partial) |
| SSM | Parameter store |
| Secrets Manager | Secrets storage |
| Route53 | DNS (basic) |
| KMS | Key management (basic) |

### Pro Tier Only (not required)

- ECS / EKS (full support)
- CloudWatch Metrics (full)
- WAF
- CloudFront
- Cognito

### Unsupported (even in Pro)

- Some very recent service additions
- Services requiring physical hardware (AWS Ground Station, etc.)

---

## 7. Stopping and Restarting LocalStack

```bash
# Stop
docker stop localstack

# Start again
docker start localstack

# Remove and recreate fresh
docker rm -f localstack
docker run -d --name localstack -p 4566:4566 -p 4510-4559:4510-4559 -e LOCALSTACK_AUTH_TOKEN=<your-token> localstack/localstack
```

**Important:** Stopping the container **preserves** your data. Removing the container **destroys** all resources.

---

## 8. Key Takeaways

- LocalStack runs in Docker on a single port (`4566`)
- All AWS services are accessed through one endpoint
- The Web UI provides visual resource management
- Free tier covers all services needed for this curriculum
- Data persists as long as the container exists (no removal)

---

## 9. Troubleshooting

| Problem | Solution |
|---------|----------|
| `docker: command not found` | Install Docker Desktop |
| Port 4566 already in use | Stop other services: `lsof -i :4566` |
| Container exits immediately | Check Docker resources (RAM/CPU) |
| Web UI not loading | Use `http://localhost:4566` instead of `localhost.localstack.cloud` |
| Health check returns empty | Wait 10-20 seconds for startup |
