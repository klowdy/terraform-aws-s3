resource "aws_s3_bucket" "this" {
  count = var.create ? 1 : 0
  
  bucket = var.name

  acl                 = var.acl
  force_destroy       = var.force_destroy
  #acceleration_status = var.acceleration_status
  region              = var.region
  request_payer       = var.request_payer
  
  dynamic "server_side_encryption_configuration" {
    for_each = var.sse_config

    content {
      rule {
        apply_server_side_encryption_by_default {
          sse_algorithm     = server_side_encryption_configuration.value.sse_key == "S3" ? "AES256" : "aws:kms"
          kms_master_key_id = server_side_encryption_configuration.value.sse_key == "S3" ? "" : server_side_encryption_configuration.value.sse_key
        }
      }
    }
  }

  dynamic "versioning" {
    for_each = var.versioning_config

    content {
      enabled    = lookup(versioning.value, "enabled", false)
      mfa_delete = lookup(versioning.value, "mfa_delete", false)
    }
  }

  dynamic "lifecycle_rule" {
    for_each = var.lifecycle_rules

    content {
      id      = lifecycle_rule.value.id
      prefix  = lifecycle_rule.value.prefix
      tags    = lifecycle_rule.value.tags
      enabled = lifecycle_rule.value.enabled
      
      abort_incomplete_multipart_upload_days = lifecycle_rule.value.abort_incomplete_multipart_upload_days

      dynamic "expiration" {
        for_each = lifecycle_rule.value.expiration_config

        content {
          days = expiration.value.days
          expired_object_delete_marker = expiration.value.expired_object_delete_marker
        }
      }

      dynamic "noncurrent_version_expiration" {
        for_each = lifecycle_rule.value.noncurrent_version_expiration_config

        content {
          days = noncurrent_version_expiration.value.days
        }
      }

      dynamic "transition" {
        for_each = lifecycle_rule.value.transitions_config 

        content {
          days          = transition.value.days
          storage_class = transition.value.storage_class
        }
      }

      dynamic "noncurrent_version_transition" {
        for_each = lifecycle_rule.value.noncurrent_version_transitions_config 

        content {
          days          = noncurrent_version_transition.value.days
          storage_class = noncurrent_version_transition.value.storage_class
        }
      }
    }
  }

  dynamic "website" {
    for_each = var.static_website_config

    content {
      index_document           = lookup(website.value, "index_document", null)
      error_document           = lookup(website.value, "error_document", null)
      redirect_all_requests_to = lookup(website.value, "redirect_all_requests_to", null)
      routing_rules            = lookup(website.value, "routing_rules", null)
    }
  }

  dynamic "cors_rule" {
    for_each = var.cors_rules

    content {
      allowed_headers = cors_rule.value.allowed_headers
      allowed_methods = cors_rule.value.allowed_methods
      allowed_origins = cors_rule.value.allowed_origins
      expose_headers  = cors_rule.value.expose_headers
      max_age_seconds = cors_rule.value.max_age_seconds
    }
  }

  tags = merge(
    {
      "Name" = format("%s", var.name)
    },
    var.tags
  )
}

resource "aws_s3_bucket_public_access_block" "this" {
  count = var.create ? 1 : 0

  bucket = aws_s3_bucket.this[0].id

  block_public_acls       = var.remove_public_access_block ? false : var.block_public_acls
  block_public_policy     = var.remove_public_access_block ? false : var.block_public_policy
  ignore_public_acls      = var.remove_public_access_block ? false : var.ignore_public_acls
  restrict_public_buckets = var.remove_public_access_block ? false : var.restrict_public_buckets

  depends_on = [aws_s3_bucket.this, aws_s3_bucket_policy.custom, aws_s3_bucket_policy.owner]
}
