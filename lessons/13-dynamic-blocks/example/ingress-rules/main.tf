resource "aws_security_group" "main" {
  name        = "dynamic-sg"
  description = "Security group with dynamic ingress rules"

  dynamic "ingress" {
    for_each = local.rules
    content {
      from_port   = ingress.value.from_port
      to_port     = ingress.value.to_port
      protocol    = ingress.value.protocol
      cidr_blocks = ingress.value.cidr_blocks
    }
  }
}
