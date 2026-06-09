# Hello World — First Terraform Config

Creates a local file to demonstrate the basic Terraform workflow.

## Files

| File | Purpose |
|------|---------|
| `main.tf` | Declares a `local_file` resource |

## Usage

```bash
terraform init
terraform plan
terraform apply
cat hello.txt
terraform state list
terraform state show local_file.hello
terraform destroy
```
