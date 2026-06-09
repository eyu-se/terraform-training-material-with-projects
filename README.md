# Learning Terraform with LocalStack

A comprehensive beginner-to-advanced curriculum for learning HashiCorp Terraform using [LocalStack](https://localstack.cloud/) to emulate AWS services locally — no real AWS account required.

## Prerequisites

- Docker
- Basic terminal/command-line skills
- VS Code (or any editor)

## Curriculum

| # | Lesson | Focus |
|---|--------|-------|
| 01 | LocalStack Setup | Install, verify, explore UI |
| 02 | AWS CLI + LocalStack | CLI configuration, manual resource creation |
| 03 | Terraform Install | Install, basic workflow (init/plan/apply/destroy) |
| 04 | Terraform AWS Provider | Connect Terraform to LocalStack |
| 05 | Resources | S3, DynamoDB, SQS resources |
| 06 | Variables | Input variables, types, tfvars |
| 07 | Outputs | Output values, sensitive outputs |
| 08 | Locals | Local values, expressions |
| 09 | Data Sources | Read existing resources |
| 10 | State Management | State inspection, manipulation |
| 11 | Dependencies | Implicit and explicit depends_on |
| 12 | Count and for_each | Meta-arguments for repetition |
| 13 | Dynamic Blocks | Dynamic nested block generation |
| 14 | Conditionals | Ternary expressions, conditional creation |
| 15 | Modules Basics | Module structure, inputs/outputs |
| 16 | Reusable Modules | S3, SQS, DynamoDB modules |
| 17 | Multi-Environment | Dev/QA/Prod patterns |
| 18 | Project: Document Storage | S3 + DynamoDB |
| 19 | Project: Order Queue | SQS + SNS + DynamoDB |
| 20 | Project: Serverless API | Lambda + API Gateway + DynamoDB |

## How to Use

Each lesson folder contains:

- **`lesson.md`** — Concepts, tutorial, code snippets
- **`exercise.md`** — Tasks to complete independently
- **`example/`** — Working Terraform project (ready to `terraform apply`)
- **`answer/`** — Solution to the exercise

## Key Principles

- Standard `terraform` commands (no `tflocal`)
- Standard `aws` CLI with `--endpoint-url=http://localhost:4566`
- LocalStack Web UI for visual verification
- Skills transfer directly to real AWS

## Quick Start

```bash
# Start LocalStack
docker run -d --name localstack -p 4566:4566 -p 4510-4559:4510-4559 localstack/localstack

# Begin with Lesson 1
code lessons/01-localstack-setup/
```
TF_LOG=TRACE before a terraform command to see detailed trace log


## Training Author -  Eyuel M. 
 
