#~~~~~~~~~~~~~~~~~~~~~~~
# Using S3 Managed Key
#~~~~~~~~~~~~~~~~~~~~~~~
module "s3_kms" {
  source = "../../"
  
  create = true
  name   = "unique-bucket-name-kms"

  sse_config = [{
    sse_key = "S3"
  }]
}

#~~~~~~~~~~~~~~~~
# Using KMS CMK
#~~~~~~~~~~~~~~~~
resource "aws_kms_key" "s3" {
  count       = 1
  description = "KMS key to encrypt S3 bucket"
}

module "s3_kms_cmk" {
  source = "../../"
  
  create = true
  name   = "unique-bucket-name-cmk"

  sse_config = [{
    sse_key = concat(aws_kms_key.s3.*.id,[""])[0]
  }]
}
