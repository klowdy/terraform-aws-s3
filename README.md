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

## Defaults

Unless otherwise specified, this module will create a bucket with the following:

- Public access block
- `private `Canned ACL
- Bucket policy which grants the account owner admin access

## Basic Implementation

The following is the most basic implementation for this module

```hcl
module "s3_basic" {
  source = "klowdy/s3/aws"
  
  create = true
  name   = "unique-bucket-name"
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
