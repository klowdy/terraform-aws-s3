resource "aws_s3_bucket_policy" "custom" {
  count  = var.create && !var.grant_owner_access && length(var.policy_document) > 0 ? 1 : 0
  bucket = aws_s3_bucket.this[0].id
  policy = var.policy_document

  depends_on = [aws_s3_bucket.this]
}

resource "aws_s3_bucket_policy" "owner" {
  count  = var.create && var.grant_owner_access ? 1 : 0
  bucket = aws_s3_bucket.this[0].id
  policy = data.aws_iam_policy_document.owner[0].json

  depends_on = [aws_s3_bucket.this]
}

#~~~~~~~~~~~~~~~~~~~~~~
# Bucket owner policy
#~~~~~~~~~~~~~~~~~~~~~~
data "aws_caller_identity" "caller" {}

data "aws_iam_policy_document" "owner" {
  count = var.create && var.grant_owner_access ? 1 : 0

  source_json = var.policy_document

  statement {
    sid = "Admin access for account owner"

    principals {
      type        = "AWS"
      identifiers = ["arn:aws:iam::${data.aws_caller_identity.caller.account_id}:root"]
    }

    actions = ["s3:*"]

    resources = [
      "arn:aws:s3:::${aws_s3_bucket.this[0].id}",
      "arn:aws:s3:::${aws_s3_bucket.this[0].id}/*",
    ]
  }
}
