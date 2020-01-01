module "s3_custom_policy" {
  source = "../../"
  
  create                     = true
  remove_public_access_block = true

  name = "unique-bucket-name-basic"
  acl  = "public-read"

  policy_document = concat(data.aws_iam_policy_document.public_read.*.json, [""])[0]
}

data "aws_iam_policy_document" "public_read" {
  count = 1

  statement {
    sid = "Public read access"

    principals {
      type        = "*"
      identifiers = ["*"]
    }

    actions = ["s3:GetObject"]

    resources = [
      "arn:aws:s3:::${module.s3_custom_policy.id}/*"
    ]
  }
}
