resource "aws_security_group" "alb_internal" {
  name        = "sg-alb-internal"
  description = "Internal ALB SG"
  vpc_id      = var.main_vpc_id

  tags = merge(var.tags, {
    Name = "sg-alb-internal"
  })
}

resource "aws_security_group" "ec2_his" {
  name        = "sg-ec2-his"
  description = "HIS EC2 App SG"
  vpc_id      = var.main_vpc_id

  tags = merge(var.tags, {
    Name = "sg-ec2-his"
  })
}

resource "aws_security_group" "rds" {
  name        = "sg-rds"
  description = "RDS SG"
  vpc_id      = var.main_vpc_id

  tags = merge(var.tags, {
    Name = "sg-rds"
  })
}

resource "aws_security_group" "staff_workstation" {
  name   = "sg-staff-workstation"
  vpc_id = var.main_vpc_id

  tags = merge(var.tags, {
    Name = "sg-staff-workstation"
  })
}

resource "aws_security_group" "iot_main" {
  name   = "sg-iot-main"
  vpc_id = var.main_vpc_id

  tags = merge(var.tags, {
    Name = "sg-iot-main"
  })
}

resource "aws_security_group" "patient_wifi" {
  name   = "sg-patient-wifi"
  vpc_id = var.main_vpc_id

  tags = merge(var.tags, {
    Name = "sg-patient-wifi"
  })
}

resource "aws_security_group_rule" "alb_from_staff_main" {
  type              = "ingress"
  security_group_id = aws_security_group.alb_internal.id
  protocol          = "tcp"
  from_port         = 443
  to_port           = 443
  cidr_blocks       = [var.staff_main_cidr]
}

resource "aws_security_group_rule" "alb_from_staff_satellite" {
  type              = "ingress"
  security_group_id = aws_security_group.alb_internal.id
  protocol          = "tcp"
  from_port         = 443
  to_port           = 443
  cidr_blocks       = [var.staff_satellite_cidr]
}

resource "aws_security_group_rule" "alb_from_vpn" {
  type              = "ingress"
  security_group_id = aws_security_group.alb_internal.id
  protocol          = "tcp"
  from_port         = 443
  to_port           = 443
  cidr_blocks       = [var.vpn_client_cidr]
}

resource "aws_security_group_rule" "alb_to_ec2" {
  type                     = "egress"
  security_group_id        = aws_security_group.alb_internal.id
  protocol                 = "tcp"
  from_port                = 8080
  to_port                  = 8080
  source_security_group_id = aws_security_group.ec2_his.id
}

resource "aws_security_group_rule" "ec2_from_alb" {
  type                     = "ingress"
  security_group_id        = aws_security_group.ec2_his.id
  protocol                 = "tcp"
  from_port                = 8080
  to_port                  = 8080
  source_security_group_id = aws_security_group.alb_internal.id
}

resource "aws_security_group_rule" "ec2_to_rds_mysql" {
  type                     = "egress"
  security_group_id        = aws_security_group.ec2_his.id
  protocol                 = "tcp"
  from_port                = 3306
  to_port                  = 3306
  source_security_group_id = aws_security_group.rds.id
}

resource "aws_security_group_rule" "ec2_to_rds_pg" {
  type                     = "egress"
  security_group_id        = aws_security_group.ec2_his.id
  protocol                 = "tcp"
  from_port                = 5432
  to_port                  = 5432
  source_security_group_id = aws_security_group.rds.id
}

resource "aws_security_group_rule" "ec2_https_out" {
  type              = "egress"
  security_group_id = aws_security_group.ec2_his.id
  protocol          = "tcp"
  from_port         = 443
  to_port           = 443
  cidr_blocks       = ["0.0.0.0/0"]
}

resource "aws_security_group_rule" "rds_from_ec2_mysql" {
  type                     = "ingress"
  security_group_id        = aws_security_group.rds.id
  protocol                 = "tcp"
  from_port                = 3306
  to_port                  = 3306
  source_security_group_id = aws_security_group.ec2_his.id
}

resource "aws_security_group_rule" "rds_from_ec2_pg" {
  type                     = "ingress"
  security_group_id        = aws_security_group.rds.id
  protocol                 = "tcp"
  from_port                = 5432
  to_port                  = 5432
  source_security_group_id = aws_security_group.ec2_his.id
}

resource "aws_security_group_rule" "staff_to_alb" {
  type                     = "egress"
  security_group_id        = aws_security_group.staff_workstation.id
  protocol                 = "tcp"
  from_port                = 443
  to_port                  = 443
  source_security_group_id = aws_security_group.alb_internal.id
}

resource "aws_security_group_rule" "staff_https" {
  type              = "egress"
  security_group_id = aws_security_group.staff_workstation.id
  protocol          = "tcp"
  from_port         = 443
  to_port           = 443
  cidr_blocks       = ["0.0.0.0/0"]
}

resource "aws_security_group_rule" "staff_http" {
  type              = "egress"
  security_group_id = aws_security_group.staff_workstation.id
  protocol          = "tcp"
  from_port         = 80
  to_port           = 80
  cidr_blocks       = ["0.0.0.0/0"]
}

resource "aws_security_group_rule" "iot_https" {
  type              = "egress"
  security_group_id = aws_security_group.iot_main.id
  protocol          = "tcp"
  from_port         = 443
  to_port           = 443
  cidr_blocks       = ["0.0.0.0/0"]
}

resource "aws_security_group_rule" "patient_https" {
  type              = "egress"
  security_group_id = aws_security_group.patient_wifi.id
  protocol          = "tcp"
  from_port         = 443
  to_port           = 443
  cidr_blocks       = ["0.0.0.0/0"]
}

resource "aws_security_group_rule" "patient_http" {
  type              = "egress"
  security_group_id = aws_security_group.patient_wifi.id
  protocol          = "tcp"
  from_port         = 80
  to_port           = 80
  cidr_blocks       = ["0.0.0.0/0"]
}