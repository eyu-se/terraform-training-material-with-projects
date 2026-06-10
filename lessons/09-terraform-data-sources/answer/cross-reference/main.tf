resource "aws_sqs_queue" "driven" {
  name = "data-driven-queue"

  tags = {
    SourceBucket = data.aws_s3_bucket.source.id
    SourceTable  = data.aws_dynamodb_table.source.arn
    AccountID    = data.aws_caller_identity.current.account_id
    Region       = data.aws_region.current.region
  }
}

data "aws_iam_policy_document" "bucket_access" {
  statement {
    sid    = "AllowPublicGetObject"
    effect = "Allow"

    principals {
      type        = "*"
      identifiers = ["*"]
    }

    actions   = ["s3:GetObject"]
    resources = ["${data.aws_s3_bucket.source.arn}/*"]
  }
}

resource "aws_s3_bucket_policy" "main" {
  bucket = data.aws_s3_bucket.source.id
  policy = data.aws_iam_policy_document.bucket_access.json
}
