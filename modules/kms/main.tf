data "aws_caller_identity" "current" {}

locals {
  arn_iam_user_list = [for name in var.iam_user_list : "arn:aws:iam::${data.aws_caller_identity.current.account_id}:user/${name}"]
  
  kms_keys = {
    rds = "An symmetric encryption KMS key for RDS"
    s3  = "An symmetric encryption KMS key for S3"
    ebs = "An symmetric encryption KMS key for EBS of EC2 volume"
  }
}

resource "aws_kms_key" "main" {
  for_each                = local.kms_keys
  description             = each.value
  enable_key_rotation     = true
  deletion_window_in_days = 20

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Sid    = "Enable IAM User Permissions"
        Effect = "Allow"
        Principal = {
          AWS = "arn:aws:iam::${data.aws_caller_identity.current.account_id}:root"
        },
        Action   = "kms:*"
        Resource = "*"
      },
      {
        Sid    = "Allow access for Key Users"
        Effect = "Allow"
        Principal = {
          AWS = local.arn_iam_user_list
        },
        Action = [
          "kms:Create*",
          "kms:Describe*",
          "kms:Enable*",
          "kms:List*",
          "kms:Put*",
          "kms:Update*",
          "kms:Revoke*",
          "kms:Disable*",
          "kms:Get*",
          "kms:Delete*",
          "kms:ScheduleKeyDeletion",
          "kms:CancelKeyDeletion",
          "kms:Encrypt",
          "kms:Decrypt",
          "kms:ReEncrypt*",
          "kms:GenerateDataKey*",
          "kms:DescribeKey"
        ],
        Resource = "*"
      },
      {
        Sid    = "Allow attachment of persistent resources"
        Effect = "Allow"
        Principal = {
          AWS = local.arn_iam_user_list
        },
        Action = [
          "kms:CreateGrant",
          "kms:ListGrants",
          "kms:RevokeGrant"
        ],
        Resource = "*",
        Condition = {
          Bool = {
            "kms:GrantIsForAWSResource" = "true"
          }
        }
      }
    ]
  })

  tags = { Name = "${each.key}-kms-key" }
}

resource "aws_kms_alias" "main" {
  for_each      = local.kms_keys
  name          = "alias/${each.key}-key-alias"
  target_key_id = aws_kms_key.main[each.key].key_id
}