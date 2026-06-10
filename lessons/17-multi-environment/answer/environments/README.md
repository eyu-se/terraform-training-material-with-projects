# Answer — Environments with All Three Approaches

Complete solution demonstrating directory-per-env, var-files, and workspaces.

## Structure

```
environments/
├── directory-per-env/
│   ├── modules/s3-bucket/
│   ├── dev/
│   │   ├── main.tf
│   │   ├── provider.tf
│   │   ├── variables.tf
│   │   ├── terraform.tfvars
│   │   └── outputs.tf
│   └── prod/
│       └── (same structure)
│
├── var-files/
│   ├── main.tf
│   ├── provider.tf
│   ├── variables.tf
│   ├── modules/s3-bucket/
│   ├── modules/sqs-queue/
│   ├── dev.tfvars
│   └── prod.tfvars
│
└── workspaces/
    ├── main.tf
    ├── provider.tf
    ├── variables.tf
    ├── modules/s3-bucket/
    └── modules/sqs-queue/
```

## Usage

### Directory-per-env

```bash
cd directory-per-env/dev
terraform init
terraform apply

cd ../prod
terraform init
terraform apply
```

### Var files

```bash
cd var-files
terraform init
terraform apply -var-file="dev.tfvars"
terraform apply -var-file="prod.tfvars"
```

### Workspaces

```bash
cd workspaces
terraform init
terraform workspace new dev
terraform workspace new prod
terraform workspace select dev
terraform apply -auto-approve
terraform workspace select prod
terraform apply -auto-approve
```
