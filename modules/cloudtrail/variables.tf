variable "cloudtrail_bucket_id" {
  type = string
}

variable "cloudtrail_log_group_arn" {
  type = string
}

variable "kms_s3_key_arn" {
  type = string
}

variable "tags" {
  type = map(string)
}
