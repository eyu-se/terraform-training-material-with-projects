# Exercise 17: Multi-Environment

## Prerequisites

- LocalStack running
- Terraform installed

## Task 1: Create Modules and Environment Configs

Create this directory structure:

```
multi-env-exercise/
├── modules/
│   └── s3-bucket/
│       ├── main.tf
│       ├── variables.tf
│       └── outputs.tf
├── dev/
│   ├── main.tf
│   ├── provider.tf
│   ├── variables.tf
│   └── terraform.tfvars
└── prod/
    ├── main.tf
    ├── provider.tf
    ├── variables.tf
    └── terraform.tfvars
```

Create the `s3-bucket` module (from lesson 16) and add a variable for `environment`.

In `dev/terraform.tfvars`:
```hcl
environment     = "dev"
bucket_name     = "multi-env-dev-data"
enable_versioning = true
tags = {
  Environment = "dev"
}
```

In `prod/terraform.tfvars`:
```hcl
environment     = "prod"
bucket_name     = "multi-env-prod-data"
enable_versioning = false
tags = {
  Environment = "prod"
}
```

**Deliverable:** Show the directory structure with `find multi-env-exercise -type f`.

---

## Task 2: Deploy Both Environments

```bash
# Deploy dev
cd multi-env-exercise/dev
terraform init
terraform apply

# Deploy prod
cd ../prod
terraform init
terraform apply
```

Verify both environments created their resources independently.

**Deliverable:** Paste `aws --endpoint-url=http://localhost:4566 s3 ls` showing both buckets.

---

## Task 3: Single Directory with Var Files

Create a second approach in `multi-env-vars/`:

```
multi-env-vars/
├── main.tf
├── provider.tf
├── variables.tf
├── modules/
│   └── s3-bucket/
├── dev.tfvars
└── prod.tfvars
```

Deploy both environments from the same directory using `-var-file`:

```bash
cd multi-env-vars
terraform init
terraform apply -var-file="dev.tfvars"
terraform apply -var-file="prod.tfvars"
```

**Question:** What happens when you run the second `apply` with a different var file? Why?

---

## Task 4: Workspaces

Create a third approach in `multi-env-workspaces/`:

1. Copy the same config (no separate tfvars, use `terraform.workspace` in locals)
2. Create workspaces:
   ```bash
   terraform workspace new dev
   terraform workspace new prod
   ```
3. Deploy each:
   ```bash
   terraform workspace select dev
   terraform apply -auto-approve

   terraform workspace select prod
   terraform apply -auto-approve
   ```

**Deliverable:** Paste `terraform workspace list` and `terraform state list` for both workspaces.

---

## Task 5: Compare Approaches

For each approach, note:

1. How many state files exist?
2. How many provider configurations?
3. What happens if you accidentally apply the wrong vars?
4. Which approach would you use for a team of 5 people?

**Deliverable:** Write a short comparison in your own words.

---

## Bonus Challenge

Add an SQS queue module to your workspace approach. Use `terraform.workspace` to set different `delay_seconds` per environment (dev: 5s, prod: 0s) and `message_retention_seconds` (dev: 1 day, prod: 7 days).
