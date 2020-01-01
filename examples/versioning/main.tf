module "s3_versioning" {
  source = "../../"
  
  create = true
  name   = "unique-bucket-name-versioning"

  versioning_config = [{
    enabled    = true
  }]
}

module "s3_versioning_mfa_delete" {
  source = "../../"
  
  create = true
  name   = "unique-bucket-name-versioning"

  versioning_config = [{
    enabled    = true
    mfa_delete = true
  }]
}
