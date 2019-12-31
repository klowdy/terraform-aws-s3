# Static Website

This example illustrates the module configuration for creating an S3 bucket to host a Static Website

Important points to note:

- `remove_public_access_block` should be set to true
- `acl` should be set to `public-read`
- A `policy_document` should be supplied that grants read access to the internet
