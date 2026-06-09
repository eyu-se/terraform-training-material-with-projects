resource "aws_security_group" "main" {
  name        = "dynamic-sg"
  description = "Security group with dynamic ingress"

  dynamic "ingress" {
    for_each = local.ingress_rules
    iterator = rule
    content {
      from_port   = rule.value.from_port
      to_port     = rule.value.to_port
      protocol    = rule.value.protocol
      cidr_blocks = rule.value.cidr_blocks
    }
  }
}


resource "aws_s3_bucket" "logging" {
  bucket = "logging-target-bucket"
}

resource "aws_s3_bucket" "main" {
  bucket = "main-app-bucket"

  dynamic "logging" {
    for_each = var.enable_logging ? [1] : []
    content {
      target_bucket = aws_s3_bucket.logging.id
      target_prefix = "logs/"
    }
  }
}
