# Local Module — S3 Bucket Module with Versioning

A reusable S3 bucket module with variables and outputs.

## Structure

```
local-module/
├── main.tf
├── provider.tf
├── outputs.tf
└── modules/
    └── s3-bucket/
        ├── main.tf
        ├── variables.tf
        └── outputs.tf
```

## Files

### Root (local-module/)

| File | Purpose |
|------|---------|
| `provider.tf` | LocalStack AWS provider config |
| `main.tf` | Calls s3-bucket module (twice for data + logs) |
| `outputs.tf` | Exposes module outputs |

### Module (modules/s3-bucket/)

| File | Purpose |
|------|---------|
| `main.tf` | aws_s3_bucket + aws_s3_bucket_versioning |
| `variables.tf` | bucket_name, enable_versioning, tags |
| `outputs.tf` | bucket_id, bucket_arn, versioning_status |

## Usage

```bash
terraform init
terraform apply

# See module outputs
terraform output

# State shows module prefixes
terraform state list

terraform destroy
```
