# Lifecycle Rules Example

Optional Object attributes are not yet supported in Terraform.  As a consequence, if you implement a lifecycle rule with this module, you will need to specify a value for every implemented attribute

To help, the below table shows you the value to specify if you do not wish to implement that lifecycle rule attribute

|Rule attribute|Required|Type|Value to specify when not implemented|
|-|-|-|-|
|`id`|Yes|`string`|N/A|
|`enabled`|Yes|`bool`|N/A|
|`prefix`|No|`string`|`""`|
|`abort_incomplete_multipart_upload_days`|No|`number`|`0`|
|`tags`|No|`map(string)`|`{}`|
|`expiration_config`|No|`list(object())`|`[]`|
|`expiration_config.days`|Yes (if `expiration_config` block is implemented)|`number`|`0`|
|`expiration_config.expired_object_delete_marker`|Yes (if `expiration_config` block is implemented)|`bool`|N/A|
|`noncurrent_version_expiration_config`|No|`list(object())`|`[]`|
|`noncurrent_version_expiration_config.days`|Yes (if `expiration_config` block is implemented)|`number`|`0`|
|`transitions_config`|No|`list(object())`|`[]`|
|`transitions_config.days`|Yes (if `expiration_config` block is implemented)|`number`|`0`|
|`noncurrent_version_transitions_config`|No|`list(object())`|`[]`|
|`noncurrent_version_transitions_config.days`|Yes (if `expiration_config` block is implemented)|`number`|`0`|

## Basic Lifecycle Rule Implementation

Because of the aforementioned constraint (optional Object attributes), the most basic lifecycle rule implementation will look something like this:

```hcl
{
  id                                     = "basic"
  enabled                                = true
  prefix                                 = ""
  tags                                   = {}
  abort_incomplete_multipart_upload_days = 0
  expiration_config = [
    {
      days = 180
      expired_object_delete_marker = false
    }
  ]
  noncurrent_version_expiration_config  = []
  transitions_config                    = []
  noncurrent_version_transitions_config = []
}
```