resource "aws_cloudwatch_log_group" "cloudtrail" {
  name              = "/aws/cloudtrail/hospital"
  retention_in_days = 90
}

resource "aws_cloudwatch_log_group" "flow_main" {
  name              = "/aws/vpc/main-hospital-flowlogs"
  retention_in_days = 30
}

resource "aws_cloudwatch_log_group" "flow_satellite" {
  name              = "/aws/vpc/satellite-flowlogs"
  retention_in_days = 30
}

resource "aws_cloudwatch_log_group" "ec2_his" {
  name              = "/aws/ec2/his-app"
  retention_in_days = 30
}

resource "aws_cloudwatch_log_group" "rds" {
  name              = "/aws/rds/hospital"
  retention_in_days = 30
}


resource "aws_sns_topic" "alarms" {
  name = "hospital-alarms"
}

resource "aws_sns_topic_subscription" "email" {
  topic_arn = aws_sns_topic.alarms.arn
  protocol  = "email"
  endpoint  = var.sns_alarm_email
}


resource "aws_cloudwatch_metric_alarm" "alb_unhealthy" {
  alarm_name          = "alb-unhealthy-hosts"
  comparison_operator = "GreaterThanOrEqualToThreshold"
  threshold           = 1
  evaluation_periods  = 1
  period              = 300
  statistic           = "Maximum"

  namespace   = "AWS/ApplicationELB"
  metric_name = "UnHealthyHostCount"

  dimensions = {
    LoadBalancer = var.alb_arn_suffix
  }

  alarm_actions = [aws_sns_topic.alarms.arn]
}


resource "aws_cloudwatch_metric_alarm" "ec2_cpu" {
  alarm_name          = "ec2-high-cpu"
  comparison_operator = "GreaterThanOrEqualToThreshold"
  threshold           = 80
  evaluation_periods  = 1
  period              = 300
  statistic           = "Average"

  namespace   = "AWS/EC2"
  metric_name = "CPUUtilization"

  dimensions = {
    InstanceId = var.ec2_his_az1_id
  }

  alarm_actions = [aws_sns_topic.alarms.arn]
}


resource "aws_cloudwatch_metric_alarm" "rds_conn" {
  alarm_name          = "rds-high-connections"
  comparison_operator = "GreaterThanOrEqualToThreshold"
  threshold           = 80
  evaluation_periods  = 1
  period              = 300
  statistic           = "Average"

  namespace   = "AWS/RDS"
  metric_name = "DatabaseConnections"

  dimensions = {
    DBInstanceIdentifier = var.rds_instance_id
  }

  alarm_actions = [aws_sns_topic.alarms.arn]
}


resource "aws_cloudwatch_log_metric_filter" "vpn_failed_auth" {
  name           = "vpn-failed-auth-filter"
  log_group_name = aws_cloudwatch_log_group.cloudtrail.name
  pattern        = "Failed authentication"

  metric_transformation {
    name      = "VPNFailedAuth"
    namespace = "HospitalVPN"
    value     = "1"
  }
}

resource "aws_cloudwatch_metric_alarm" "vpn_failed" {
  alarm_name          = "vpn-failed-auth"
  comparison_operator = "GreaterThanOrEqualToThreshold"
  threshold           = 5
  evaluation_periods  = 1
  period              = 600
  statistic           = "Sum"

  namespace   = "HospitalVPN"
  metric_name = "VPNFailedAuth"

  alarm_actions = [aws_sns_topic.alarms.arn]
}


resource "aws_cloudwatch_dashboard" "main" {
  dashboard_name = "HospitalInfrastructure"

  dashboard_body = jsonencode({
    widgets = [
      {
        type = "metric"
        x = 0
        y = 0
        width = 12
        height = 6

        properties = {
          metrics = [
            ["AWS/ApplicationELB", "RequestCount", "LoadBalancer", var.alb_arn_suffix]
          ]
          period = 300
          stat   = "Sum"
          title  = "ALB Requests"
          region = "ap-southeast-1"
        }
      },

      {
        type = "metric"
        x = 12
        y = 0
        width = 12
        height = 6

        properties = {
          metrics = [
            ["AWS/EC2", "CPUUtilization", "InstanceId", var.ec2_his_az1_id]
          ]
          period = 300
          stat   = "Average"
          title  = "EC2 CPU"
          region = "ap-southeast-1"
        }
      }
    ]
  })
}