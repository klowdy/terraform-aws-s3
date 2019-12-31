module "s3_lifecycle_rules" {
  source = "../../"
  
  create             = true
  grant_owner_access = true

  name       = "unique-bucket-name-lifecycle-rules"
  account_id = "123456789012"

  versioning_config = {
    enabled    = true
    mfa_delete = false
  }

  lifecycle_rules = [
    {
      id                                     = "basic"
      enabled                                = true
      prefix                                 = ""
      tags                                   = {}
      abort_incomplete_multipart_upload_days = 0
      expiration_config = [
        {
          days = 180
          expired_object_delete_marker = false
        }
      ]
      noncurrent_version_expiration_config  = []
      transitions_config                    = []
      noncurrent_version_transitions_config = []
    },
    {
      id                                     = "complete"
      enabled                                = true
      prefix                                 = "*"
      tags = {
        "Environment" = "Dev"
      }
      abort_incomplete_multipart_upload_days = 30
      expiration_config = [
        {
          days = 180
          expired_object_delete_marker = false
        }
      ]
      noncurrent_version_expiration_config = [
        {
          days = 150
        }
      ]
      transitions_config = [
        {
          days = 90
          storage_class = "STANDARD_IA"
        }
      ]
      noncurrent_version_transitions_config = [
        {
          days = 120
          storage_class = "GLACIER"
        }
      ]
    }
  ]
}
