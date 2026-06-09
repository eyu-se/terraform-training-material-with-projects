# Answer — Chained Dependencies with Mixed Dep Types

Complete exercise solution showing implicit, explicit, and chained dependencies.

## Files

| File | Purpose |
|------|---------|
| `provider.tf` | LocalStack AWS provider config |
| `main.tf` | S3 bucket (root), versioning (implicit), queue (explicit depends_on), table (chained) |

## Usage

```bash
terraform init
terraform apply

# See dependency order
terraform state list
terraform graph

# Install graphviz then render
terraform graph | dot -Tpng > graph.png

terraform destroy
```
