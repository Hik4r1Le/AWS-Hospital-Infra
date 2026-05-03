resource "aws_guardduty_detector" "main" {
  enable = true

  datasources {
    s3_logs {
      enable = true
    }
    kubernetes {
      audit_logs {
        enable = false
      }
    }
    malware_protection {
      scan_ec2_instance_with_findings {
        ebs_volumes {
          enable = true
        }
      }
    }
  }

  tags = merge(var.tags, {
    Name = "hospital-guardduty"
  })
}

resource "aws_guardduty_publishing_destination" "s3" {
  detector_id     = aws_guardduty_detector.main.id
  destination_arn = var.cloudtrail_bucket_arn
  kms_key_arn     = var.kms_s3_key_arn
}
