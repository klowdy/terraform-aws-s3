module "s3" {
  source = "../../"
  
  create = var.create_s3
  name = "${var.account_id}-test-bucket"

  sse_config = [{sse_key = "S3"}]

  versioning_config = {
    enabled    = true
    mfa_delete = false
  }

  # lifecycle_rules = [
  #   {
  #     id                                     = "temp"
  #     prefix                                 = "/tmp"
  #     abort_incomplete_multipart_upload_days = null
  #     enabled                                = true
  #     expiration_days                        = 180
  #     tags = {
  #       "Type" = "Object"
  #       "Product" = "prod_one"
  #     }
  #     transitions = [
  #       {
  #         days = 90
  #         storage_class = "STANDARD_IA"
  #       }
  #     ]
  #     noncurrent_version_transitions = [
  #       {
  #         days = 120
  #         storage_class = "GLACIER"
  #       }
  #     ]
  #   }
  # ]

  replication_configurations = [{
    role  = module.test_s3.arn
    rules = [
      {
        id       = "rep_1"
        priority = 1
        prefix   = ""
        status   = "Disabled"
        destination = {
          bucket_arn    = module.s3_replication.arn
          account_id    = var.account_id
          storage_class = "STANDARD_IA"
        }
      }
    ]
  }]
}

module "s3_replication" {
  source = "../modules-project/s3/"
  
  create = var.create_s3
  name = "${var.account_id}-test-bucket-replication"

  sse_config = [{sse_key = "S3"}]

  versioning_config = {
    enabled    = true
    mfa_delete = false
  }
}