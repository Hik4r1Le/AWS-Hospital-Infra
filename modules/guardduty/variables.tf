variable "cloudtrail_bucket_arn" {
  type = string
}

variable "kms_s3_key_arn" {
  type = string
}

variable "tags" {
  type = map(string)
}
