module "s3_cors" {
  source = "../../"
  
  create                     = true
  remove_public_access_block = true

  name = "s3-website-test.mydomain.com"
  acl  = "public-read"

  cors_rules = [
    {
      allowed_headers = ["*"]
      allowed_methods = ["PUT", "POST"]
      allowed_origins = ["https://s3-website-test.mydomain.com"]
      expose_headers  = ["ETag"]
      max_age_seconds = 3000
    }
  ]
}