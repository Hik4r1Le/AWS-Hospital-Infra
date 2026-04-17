output "rds_key_id" {
  value = aws_kms_key.main["rds"].key_id
}

output "rds_key_arn" {
  value = aws_kms_key.main["rds"].arn
}

output "rds_alias_name" {
  value = aws_kms_alias.main["rds"].name
}

output "s3_key_id" {
  value = aws_kms_key.main["s3"].key_id
}

output "s3_key_arn" {
  value = aws_kms_key.main["s3"].arn
}

output "s3_alias_name" {
  value = aws_kms_alias.main["s3"].name
}

output "ebs_key_id" {
  value = aws_kms_key.main["ebs"].key_id
}

output "ebs_key_arn" {
  value = aws_kms_key.main["ebs"].arn
}

output "ebs_alias_name" {
  value = aws_kms_alias.main["ebs"].name
}
