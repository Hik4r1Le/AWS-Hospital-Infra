output "cloudtrail_bucket_id" {
  value = aws_s3_bucket.cloudtrail_logs.id
}

output "cloudtrail_bucket_arn" {
  value = aws_s3_bucket.cloudtrail_logs.arn
}

output "terraform_state_bucket_id" {
  value = aws_s3_bucket.terraform_state.id
}

output "terraform_state_bucket_arn" {
  value = aws_s3_bucket.terraform_state.arn
}
