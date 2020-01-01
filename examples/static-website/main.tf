module "s3_static_website" {
  source = "../../"
  
  create                     = true
  remove_public_access_block = true

  name       = "s3-website-test.mydomain.com"
  acl        = "public-read"

  policy_document = concat(data.aws_iam_policy_document.public_read.*.json, [""])[0]

  static_website_config = [
    {
      index_document           = "index.html"
      error_document           = "error.html"
      routing_rules            = <<EOF
[{
    "Condition": {
        "KeyPrefixEquals": "docs/"
    },
    "Redirect": {
        "ReplaceKeyPrefixWith": "documents/"
    }
}]
EOF
    }
  ]
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