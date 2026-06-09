# Exercise 03: Terraform Installation

## Task 1: Install and Verify

1. Install Terraform using the appropriate method for your OS
2. Run `terraform version` and note the output

**Deliverable:** Paste the output of `terraform version`.

---

## Task 2: First Terraform Configuration

1. Create a directory named `terraform-exercise-03`
2. Create a file `main.tf` that uses `local_file` to create a file named `exercise.txt` with content `"Terraform exercise complete"`
3. Run `terraform init`
4. Run `terraform fmt`
5. Run `terraform validate`
6. Run `terraform plan`
7. Run `terraform apply` (type `yes` when prompted)
8. Verify the file was created: `cat exercise.txt`

**Deliverable:** Paste the output of `terraform plan` and `cat exercise.txt`.

---

## Task 3: Inspect State

1. Run `terraform state list`
2. Run `terraform state show local_file.exercise`
3. Look at the raw state file: `cat terraform.tfstate`

**Question:** What is the `id` field in the state? What does it represent?

---

## Task 4: Modify and Reapply

> **Important:** Do NOT create a new directory. Edit the **existing** `main.tf` from Task 2 in the same `terraform-exercise-03` directory. Terraform uses the `terraform.tfstate` file from the previous `apply` to know what already exists.

1. Edit `main.tf` in your `terraform-exercise-03` directory. Change the `content` from `"Terraform exercise complete"` to `"Terraform exercise modified"`
2. Run `terraform plan` — it should now show `1 to change` (not `1 to add`)
3. Run `terraform apply`
4. Verify the file content changed: `cat exercise.txt`

**Deliverable:** Paste the output of `terraform plan` showing `1 to change`.

---

## Task 5: Destroy

1. Run `terraform destroy` (type `yes`)
2. Verify the file is deleted: `cat exercise.txt`
3. Run `terraform state list` — it should be empty

**Deliverable:** Paste the output of `terraform destroy`.

---

## Bonus Challenge

Explore `terraform graph`:

```bash
terraform graph | dot -Tpng > graph.png
```

(This requires Graphviz: `brew install graphviz` on macOS.)

Open the generated PNG — it shows a dependency graph of your resources. What does the graph look like for a single `local_file` resource?
