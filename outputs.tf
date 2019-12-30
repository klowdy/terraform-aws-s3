output "name" {
  description = "Name of the bucket"
  value       = concat(aws_s3_bucket.this.*.id, [""])[0]
}

output "arn" {
  description = "ARN of the bucket"
  value       = concat(aws_s3_bucket.this.*.arn, [""])[0]
}