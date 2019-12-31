module "s3_static_website" {
  source = "../../"
  
  create                     = true
  grant_owner_access         = true
  remove_public_access_block = true

  name       = "s3-website-test.mydomain.com"
  account_id = "123456789012"
  acl        = "public-read"

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