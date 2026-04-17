#################################################
# SECURITY GROUPS
#################################################

resource "aws_security_group" "alb_internal" {
  name        = "sg-alb-internal"
  description = "Internal ALB Security Group"
  vpc_id      = var.main_vpc_id

  tags = merge(var.tags, {
    Name = "sg-alb-internal"
  })
}

resource "aws_security_group" "ec2_his" {
  name        = "sg-ec2-his"
  description = "HIS Application EC2 Security Group"
  vpc_id      = var.main_vpc_id

  tags = merge(var.tags, {
    Name = "sg-ec2-his"
  })
}

resource "aws_security_group" "rds" {
  name        = "sg-rds"
  description = "RDS Database Security Group"
  vpc_id      = var.main_vpc_id

  tags = merge(var.tags, {
    Name = "sg-rds"
  })
}

resource "aws_security_group" "staff_workstation" {
  name        = "sg-staff-workstation"
  description = "Staff Workstation Security Group"
  vpc_id      = var.main_vpc_id

  tags = merge(var.tags, {
    Name = "sg-staff-workstation"
  })
}

resource "aws_security_group" "iot_main" {
  name        = "sg-iot-main"
  description = "IoT Devices Security Group"
  vpc_id      = var.main_vpc_id

  tags = merge(var.tags, {
    Name = "sg-iot-main"
  })
}

resource "aws_security_group" "patient_wifi" {
  name        = "sg-patient-wifi"
  description = "Patient WiFi Security Group"
  vpc_id      = var.main_vpc_id

  tags = merge(var.tags, {
    Name = "sg-patient-wifi"
  })
}

#################################################
# ALB INTERNAL RULES
#################################################

resource "aws_vpc_security_group_ingress_rule" "alb_from_staff_main" {
  security_group_id = aws_security_group.alb_internal.id
  cidr_ipv4         = var.staff_main_cidr
  from_port         = 443
  to_port           = 443
  ip_protocol       = "tcp"
}

resource "aws_vpc_security_group_ingress_rule" "alb_from_staff_satellite" {
  security_group_id = aws_security_group.alb_internal.id
  cidr_ipv4         = var.staff_satellite_cidr
  from_port         = 443
  to_port           = 443
  ip_protocol       = "tcp"
}

resource "aws_vpc_security_group_ingress_rule" "alb_from_vpn" {
  security_group_id = aws_security_group.alb_internal.id
  cidr_ipv4         = var.vpn_client_cidr
  from_port         = 443
  to_port           = 443
  ip_protocol       = "tcp"
}

resource "aws_vpc_security_group_egress_rule" "alb_to_ec2" {
  security_group_id            = aws_security_group.alb_internal.id
  referenced_security_group_id = aws_security_group.ec2_his.id
  from_port                    = 8080
  to_port                      = 8080
  ip_protocol                  = "tcp"
}

#################################################
# EC2 HIS RULES
#################################################

resource "aws_vpc_security_group_ingress_rule" "ec2_from_alb" {
  security_group_id            = aws_security_group.ec2_his.id
  referenced_security_group_id = aws_security_group.alb_internal.id
  from_port                    = 8080
  to_port                      = 8080
  ip_protocol                  = "tcp"
}

resource "aws_vpc_security_group_egress_rule" "ec2_to_rds_mysql" {
  security_group_id            = aws_security_group.ec2_his.id
  referenced_security_group_id = aws_security_group.rds.id
  from_port                    = 3306
  to_port                      = 3306
  ip_protocol                  = "tcp"
}

resource "aws_vpc_security_group_egress_rule" "ec2_to_rds_pg" {
  security_group_id            = aws_security_group.ec2_his.id
  referenced_security_group_id = aws_security_group.rds.id
  from_port                    = 5432
  to_port                      = 5432
  ip_protocol                  = "tcp"
}

resource "aws_vpc_security_group_egress_rule" "ec2_https_out" {
  security_group_id = aws_security_group.ec2_his.id
  cidr_ipv4         = "0.0.0.0/0"
  from_port         = 443
  to_port           = 443
  ip_protocol       = "tcp"
}

#################################################
# RDS RULES
#################################################

resource "aws_vpc_security_group_ingress_rule" "rds_from_ec2_mysql" {
  security_group_id            = aws_security_group.rds.id
  referenced_security_group_id = aws_security_group.ec2_his.id
  from_port                    = 3306
  to_port                      = 3306
  ip_protocol                  = "tcp"
}

resource "aws_vpc_security_group_ingress_rule" "rds_from_ec2_pg" {
  security_group_id            = aws_security_group.rds.id
  referenced_security_group_id = aws_security_group.ec2_his.id
  from_port                    = 5432
  to_port                      = 5432
  ip_protocol                  = "tcp"
}

#################################################
# STAFF WORKSTATION RULES
#################################################

resource "aws_vpc_security_group_egress_rule" "staff_to_alb" {
  security_group_id            = aws_security_group.staff_workstation.id
  referenced_security_group_id = aws_security_group.alb_internal.id
  from_port                    = 443
  to_port                      = 443
  ip_protocol                  = "tcp"
}

resource "aws_vpc_security_group_egress_rule" "staff_https" {
  security_group_id = aws_security_group.staff_workstation.id
  cidr_ipv4         = "0.0.0.0/0"
  from_port         = 443
  to_port           = 443
  ip_protocol       = "tcp"
}

resource "aws_vpc_security_group_egress_rule" "staff_http" {
  security_group_id = aws_security_group.staff_workstation.id
  cidr_ipv4         = "0.0.0.0/0"
  from_port         = 80
  to_port           = 80
  ip_protocol       = "tcp"
}

#################################################
# IOT RULES
#################################################

resource "aws_vpc_security_group_egress_rule" "iot_https" {
  security_group_id = aws_security_group.iot_main.id
  cidr_ipv4         = "0.0.0.0/0"
  from_port         = 443
  to_port           = 443
  ip_protocol       = "tcp"
}

#################################################
# PATIENT WIFI RULES
#################################################

resource "aws_vpc_security_group_egress_rule" "patient_https" {
  security_group_id = aws_security_group.patient_wifi.id
  cidr_ipv4         = "0.0.0.0/0"
  from_port         = 443
  to_port           = 443
  ip_protocol       = "tcp"
}

resource "aws_vpc_security_group_egress_rule" "patient_http" {
  security_group_id = aws_security_group.patient_wifi.id
  cidr_ipv4         = "0.0.0.0/0"
  from_port         = 80
  to_port           = 80
  ip_protocol       = "tcp"
}