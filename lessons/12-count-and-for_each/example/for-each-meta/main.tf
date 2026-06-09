resource "aws_s3_bucket" "main" {
  for_each = var.buckets
  bucket   = "bucket-${each.key}"
}
