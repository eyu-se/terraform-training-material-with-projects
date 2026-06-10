locals {
  ingress_rules = var.enable_ssh ? var.ingress_rules : [
    for r in var.ingress_rules : r if r.from_port != 22
  ]
}
