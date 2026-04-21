output "main_flow_log_id" {
  value = aws_flow_log.main.id
}

output "satellite_flow_log_id" {
  value = aws_flow_log.satellite.id
}