# Terraform AWS S3 Module

## Features

- Versioning
- Server Side Encryption (SSE) using KMS CMK or S3-Managed keys
- Lifecycle rules
- Static Website Hosting
- CORS
- Public Access Block

## Features Not Implemented

- Acceleration status
- Replication configuration block

## Known Issues / Debt

Since optional Object attributes are not yet available as a feature within Terraform the implementation of `lifecycle_rules` is unduly verbose.  When [issue #19898](https://github.com/hashicorp/terraform/issues/19898) is resolved, this will be cleaned up

## Basic Implementation

The following creates an S3 bucket with:
- SSE  using the KMS S3 key
- A bucket policy allowing the specified `account_id` admin access

```hcl
module "s3_basic" {
  source = "klowdy/s3/aws"
  
  create             = true
  grant_owner_access = true

  name       = "unique-bucket-name"
  account_id = "123456789012"

  sse_config = [{sse_key = "S3"}]
}
```
## Examples

The following are guides for the different types of implementations supported by this module

- [basic](https://github.com/klowdy/terraform-aws-s3/tree/master/examples/basic)
- [cors](https://github.com/klowdy/terraform-aws-s3/tree/master/examples/cors)
- [custom-policy](https://github.com/klowdy/terraform-aws-s3/tree/master/examples/custom-policy)
- [encrypted](https://github.com/klowdy/terraform-aws-s3/tree/master/examples/encrypted)
- [lifecycle-rules](https://github.com/klowdy/terraform-aws-s3/tree/master/examples/lifecycle-rules)
- [static-website](https://github.com/klowdy/terraform-aws-s3/tree/master/examples/static-website)
- [versioning](https://github.com/klowdy/terraform-aws-s3/tree/master/examples/versioning)
