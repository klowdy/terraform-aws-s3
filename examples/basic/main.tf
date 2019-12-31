module "s3_basic" {
  source = "../../"
  
  create             = true
  grant_owner_access = true

  name       = "unique-bucket-name-basic"
  account_id = "123456789012"
}
