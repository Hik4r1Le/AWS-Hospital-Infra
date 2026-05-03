output "alb_dns_name" {
  value = aws_lb.main_hospital_alb.dns_name
}

output "alb_zone_id" {
  value = aws_lb.main_hospital_alb.zone_id
}

output "alb_arn_suffix" {
  value = aws_lb.main_hospital_alb.arn_suffix
}
