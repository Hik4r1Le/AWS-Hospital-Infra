output "private_zone_id" {
  value = aws_route53_zone.private.zone_id
}

output "his_dns_name" {
  value = aws_route53_record.his_app.fqdn
}

output "rds_dns_name" {
  value = aws_route53_record.rds.fqdn
}
