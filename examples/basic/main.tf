module "s3_basic" {
  source = "../../"
  
  create = true
  name   = "unique-bucket-name-basic"
}
