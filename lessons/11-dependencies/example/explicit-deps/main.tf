resource "aws_s3_bucket" "main" {
  bucket = "explicit-deps-bucket"
}

# No implicit dependency — no reference to the bucket
# But we want ordering, so we use depends_on
resource "aws_sqs_queue" "main" {
  name = "explicit-deps-queue"

  depends_on = [aws_s3_bucket.main]
}
