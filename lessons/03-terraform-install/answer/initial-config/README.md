# Initial Config — Exercise Solution

Creates `exercise.txt` with content "Terraform exercise complete".

## Files

| File | Purpose |
|------|---------|
| `main.tf` | Declares the `local_file` resource |

## Usage

```bash
terraform init
terraform plan
terraform apply
cat exercise.txt
terraform state list
terraform state show local_file.exercise
cat terraform.tfstate
```
