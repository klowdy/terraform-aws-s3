#~~~~~~~~~~
# Control
#~~~~~~~~~~
variable "create" {
  description = "Controls resource creation"
  type        = bool
  default     = false
}

variable "force_destroy" {
  description = "When set to true, will delete the bucket even if it is not empty"
  type        = bool
  default     = false
}

#~~~~~~~~~~
# Generic
#~~~~~~~~~~
variable "tags" {
  description = "A map of tags to apply to all resources"
  type        = map(string)
  default     = {}
}

#~~~~~~~~~
# Bucket
#~~~~~~~~~
variable "region" {
  description = "If specified, the AWS region this bucket should reside in. Otherwise, the region used by the callee"
  default     = ""
}

variable "name" {
  description = "Name of the resource. Conflicts with name_prefix"
  default     = ""
}

variable "acl" {
  description = "The canned ACL to apply"
  default     = "private"
}

variable "acceleration_status" {
  description = "Sets the accelerate configuration of an existing bucket. Can be Enabled or Suspended"
  default     = "Suspended"
}

variable "request_payer" {
  description = "Specifies who should bear the cost of Amazon S3 data transfer. Can be either BucketOwner or Requester"
  default     = "BucketOwner"
}

#~~~~~~~~~~~~
# SSE Block
#~~~~~~~~~~~~
variable "sse_config" {
  description = "Configures server side encryption for the bucket.  The sse_key should either be set to S3 or a KMS Key ID"
  type        = list(object({
    sse_key = string
  }))
}

#~~~~~~~~~~~~~
# Versioning
#~~~~~~~~~~~~~
variable "versioning_config" {
  description  = "Configure versioning on bucket object.  Once you version-enable a bucket, it can never return to an unversioned state. You can, however, suspend versioning on that bucket"
  type         = object({
    enabled    = bool
    mfa_delete = bool
  })
  default      = {
    enabled    = false
    mfa_delete = false
  }
}

#~~~~~~~~~~~~~~~~~~
# Lifecycle Rules
#~~~~~~~~~~~~~~~~~~
variable "lifecycle_rules" {
  description = "A data structure to create lifcycle rules"
  type        = list(object({
    id                                     = string
    prefix                                 = string
    tags                                   = map(string)
    enabled                                = bool
    abort_incomplete_multipart_upload_days = number
    expiration_days                        = number
    noncurrent_version_expiration_days     = number
    transitions = list(object({
      days          = number
      storage_class = string
    }))
    noncurrent_version_transitions = list(object({
      days          = number
      storage_class = string
    }))
  }))
  default = []
}

#~~~~~~~~~~~~~~~~~~~~~~
# Public Access Block
#~~~~~~~~~~~~~~~~~~~~~~
variable "block_public_acls" {
  description = "Whether Amazon S3 should block public ACLs for this bucket"
  type        = bool
  default     = true
}

variable "block_public_policy" {
  description = "Whether Amazon S3 should block public bucket policies for this bucket"
  type        = bool
  default     = true
}

variable "ignore_public_acls" {
  description = "Whether Amazon S3 should ignore public ACLs for this bucket"
  type        = bool
  default     = true
}

variable "restrict_public_buckets" {
  description = "Whether Amazon S3 should restrict public bucket policies for this bucket"
  type        = bool
  default     = true
}
