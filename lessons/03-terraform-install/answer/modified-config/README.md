# Modified Config — Exercise Solution

Changes the file content to demonstrate the plan/apply **update** cycle (shows `1 to change` instead of `1 to add`).

## Important

This config must be used in the **same directory** where `initial-config` was applied. Terraform reads `terraform.tfstate` to know the resource already exists and only the content needs updating.

If you apply this in a new directory, Terraform won't have state and will show `1 to add` instead.

## Usage

```bash
# Copy modified main.tf over the existing one in your working directory
cp main.tf /path/to/terraform-exercise-03/main.tf

# Navigate to your working directory
cd /path/to/terraform-exercise-03

# Plan will show: 1 to change (not 1 to add)
terraform plan

# Apply the change
terraform apply

# Verify
cat exercise.txt
```
