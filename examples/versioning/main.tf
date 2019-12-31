module "s3_versioning" {
  source = "../../"
  
  create             = true
  grant_owner_access = true

  name       = "unique-bucket-name-versioning"
  account_id = "123456789012"

  versioning_config = {
    enabled    = true
    mfa_delete = false
  }
}
