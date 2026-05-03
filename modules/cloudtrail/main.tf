data "aws_caller_identity" "current" {}
data "aws_region" "current" {}

#####################################################
# IAM Role — CloudTrail → CloudWatch Logs
#####################################################

resource "aws_iam_role" "cloudtrail_cw" {
  name = "hospital-cloudtrail-cw-role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [{
      Effect = "Allow"
      Principal = {
        Service = "cloudtrail.amazonaws.com"
      }
      Action = "sts:AssumeRole"
    }]
  })

  tags = var.tags
}

resource "aws_iam_role_policy" "cloudtrail_cw" {
  name = "hospital-cloudtrail-cw-policy"
  role = aws_iam_role.cloudtrail_cw.id

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [{
      Effect = "Allow"
      Action = [
        "logs:CreateLogStream",
        "logs:PutLogEvents"
      ]
      Resource = "${var.cloudtrail_log_group_arn}:*"
    }]
  })
}

#####################################################
# CloudTrail Trail — Multi-region, ghi S3 + CloudWatch
#####################################################

resource "aws_cloudtrail" "main" {
  name                          = "hospital-trail"
  s3_bucket_name                = var.cloudtrail_bucket_id
  include_global_service_events = true
  is_multi_region_trail         = true
  enable_log_file_validation    = true

  cloud_watch_logs_group_arn = "${var.cloudtrail_log_group_arn}:*"
  cloud_watch_logs_role_arn  = aws_iam_role.cloudtrail_cw.arn

  kms_key_id = var.kms_s3_key_arn

  event_selector {
    read_write_type           = "All"
    include_management_events = true

    # Ghi Data Events cho S3 (theo dõi GetObject, PutObject)
    data_resource {
      type   = "AWS::S3::Object"
      values = ["arn:aws:s3:::"]
    }
  }

  tags = merge(var.tags, {
    Name = "hospital-trail"
  })
}
