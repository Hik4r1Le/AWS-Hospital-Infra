variable "kms_s3_key_arn" {
  description = "ARN của KMS key dùng mã hoá S3 (từ module.kms)"
  type        = string
}

variable "tags" {
  type = map(string)
}
