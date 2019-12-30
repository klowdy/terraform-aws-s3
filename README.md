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
