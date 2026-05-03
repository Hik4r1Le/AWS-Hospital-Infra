#####################################################
# Private Hosted Zone — hospital.internal
# Dùng cho DNS nội bộ giữa EC2, RDS, ALB trong VPC
#####################################################

resource "aws_route53_zone" "private" {
  name = var.private_domain_name

  vpc {
    vpc_id = var.main_vpc_id
  }

  tags = merge(var.tags, {
    Name = "hospital-private-zone"
  })
}

#####################################################
# DNS Records
#####################################################

# HIS App (trỏ tới ALB nội bộ)
resource "aws_route53_record" "his_app" {
  zone_id = aws_route53_zone.private.zone_id
  name    = "his.${var.private_domain_name}"
  type    = "A"

  alias {
    name                   = var.alb_dns_name
    zone_id                = var.alb_zone_id
    evaluate_target_health = true
  }
}

# RDS
resource "aws_route53_record" "rds" {
  zone_id = aws_route53_zone.private.zone_id
  name    = "db.${var.private_domain_name}"
  type    = "CNAME"
  ttl     = 300
  records = [var.rds_endpoint]
}
