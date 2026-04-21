#####################################################
# Main Hospital Flow Logs
#####################################################

resource "aws_flow_log" "main" {
  iam_role_arn         = var.flow_logs_role_arn
  log_destination_type = "cloud-watch-logs"
  log_group_name       = var.main_log_group_name

  traffic_type = "ALL"

  vpc_id = var.main_vpc_id

  tags = merge(var.tags, {
    Name = "main-hospital-flowlogs"
  })
}

#####################################################
# Satellite Clinic Flow Logs
#####################################################

resource "aws_flow_log" "satellite" {
  iam_role_arn         = var.flow_logs_role_arn
  log_destination_type = "cloud-watch-logs"
  log_group_name       = var.satellite_log_group_name

  traffic_type = "ALL"

  vpc_id = var.satellite_vpc_id

  tags = merge(var.tags, {
    Name = "satellite-flowlogs"
  })
}