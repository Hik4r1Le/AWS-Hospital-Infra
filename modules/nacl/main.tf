############################################################
# modules/nacl/main.tf
# Network ACLs for AWS Hospital Infra
############################################################

############################################################
# NACL-1 PUBLIC
############################################################

resource "aws_network_acl" "public" {
  vpc_id = var.main_vpc_id

  subnet_ids = var.public_subnet_ids

  tags = merge(var.tags, {
    Name = "nacl-public"
  })
}

# INBOUND

resource "aws_network_acl_rule" "public_in_100" {
  network_acl_id = aws_network_acl.public.id
  rule_number    = 100
  egress         = false
  protocol       = "6"
  rule_action    = "allow"
  cidr_block     = "0.0.0.0/0"
  from_port      = 443
  to_port        = 443
}

resource "aws_network_acl_rule" "public_in_110" {
  network_acl_id = aws_network_acl.public.id
  rule_number    = 110
  egress         = false
  protocol       = "6"
  rule_action    = "allow"
  cidr_block     = "0.0.0.0/0"
  from_port      = 80
  to_port        = 80
}

resource "aws_network_acl_rule" "public_in_120" {
  network_acl_id = aws_network_acl.public.id
  rule_number    = 120
  egress         = false
  protocol       = "6"
  rule_action    = "allow"
  cidr_block     = "0.0.0.0/0"
  from_port      = 1024
  to_port        = 65535
}

# OUTBOUND

resource "aws_network_acl_rule" "public_out_100" {
  network_acl_id = aws_network_acl.public.id
  rule_number    = 100
  egress         = true
  protocol       = "6"
  rule_action    = "allow"
  cidr_block     = "10.0.0.0/16"
  from_port      = 0
  to_port        = 65535
}

resource "aws_network_acl_rule" "public_out_110" {
  network_acl_id = aws_network_acl.public.id
  rule_number    = 110
  egress         = true
  protocol       = "6"
  rule_action    = "allow"
  cidr_block     = "0.0.0.0/0"
  from_port      = 1024
  to_port        = 65535
}

resource "aws_network_acl_rule" "public_out_120" {
  network_acl_id = aws_network_acl.public.id
  rule_number    = 120
  egress         = true
  protocol       = "6"
  rule_action    = "allow"
  cidr_block     = "0.0.0.0/0"
  from_port      = 443
  to_port        = 443
}

############################################################
# NACL-2 CLINICAL
############################################################

resource "aws_network_acl" "clinical" {
  vpc_id     = var.main_vpc_id
  subnet_ids = var.clinical_subnet_ids

  tags = merge(var.tags, {
    Name = "nacl-clinical"
  })
}

resource "aws_network_acl_rule" "clinical_in_100" {
  network_acl_id = aws_network_acl.clinical.id
  rule_number    = 100
  egress         = false
  protocol       = "6"
  rule_action    = "allow"
  cidr_block     = "10.0.1.0/24"
  from_port      = 8080
  to_port        = 8080
}

resource "aws_network_acl_rule" "clinical_in_110" {
  network_acl_id = aws_network_acl.clinical.id
  rule_number    = 110
  egress         = false
  protocol       = "6"
  rule_action    = "allow"
  cidr_block     = "10.0.20.0/24"
  from_port      = 8080
  to_port        = 8080
}

resource "aws_network_acl_rule" "clinical_in_120" {
  network_acl_id = aws_network_acl.clinical.id
  rule_number    = 120
  egress         = false
  protocol       = "6"
  rule_action    = "allow"
  cidr_block     = var.staff_satellite_cidr
  from_port      = 8080
  to_port        = 8080
}

resource "aws_network_acl_rule" "clinical_in_130" {
  network_acl_id = aws_network_acl.clinical.id
  rule_number    = 130
  egress         = false
  protocol       = "6"
  rule_action    = "allow"
  cidr_block     = var.vpn_client_cidr
  from_port      = 8080
  to_port        = 8080
}

resource "aws_network_acl_rule" "clinical_in_200_deny_patient" {
  network_acl_id = aws_network_acl.clinical.id
  rule_number    = 200
  egress         = false
  protocol       = "-1"
  rule_action    = "deny"
  cidr_block     = var.patient_cidr
}

resource "aws_network_acl_rule" "clinical_in_210_deny_iot" {
  network_acl_id = aws_network_acl.clinical.id
  rule_number    = 210
  egress         = false
  protocol       = "-1"
  rule_action    = "deny"
  cidr_block     = var.iot_cidr
}

############################################################
# NACL-3 STAFF
############################################################

resource "aws_network_acl" "staff" {
  vpc_id     = var.main_vpc_id
  subnet_ids = var.staff_main_subnet_ids

  tags = merge(var.tags, {
    Name = "nacl-staff"
  })
}

resource "aws_network_acl_rule" "staff_out_100" {
  network_acl_id = aws_network_acl.staff.id
  rule_number    = 100
  egress         = true
  protocol       = "6"
  rule_action    = "allow"
  cidr_block     = "10.0.10.0/24"
  from_port      = 443
  to_port        = 443
}

resource "aws_network_acl_rule" "staff_out_110" {
  network_acl_id = aws_network_acl.staff.id
  rule_number    = 110
  egress         = true
  protocol       = "6"
  rule_action    = "allow"
  cidr_block     = "0.0.0.0/0"
  from_port      = 443
  to_port        = 443
}

############################################################
# NACL-4 IOT
############################################################

resource "aws_network_acl" "iot" {
  vpc_id     = var.main_vpc_id
  subnet_ids = var.iot_subnet_ids

  tags = merge(var.tags, {
    Name = "nacl-iot"
  })
}

resource "aws_network_acl_rule" "iot_out_100" {
  network_acl_id = aws_network_acl.iot.id
  rule_number    = 100
  egress         = true
  protocol       = "6"
  rule_action    = "allow"
  cidr_block     = "0.0.0.0/0"
  from_port      = 443
  to_port        = 443
}

resource "aws_network_acl_rule" "iot_out_200" {
  network_acl_id = aws_network_acl.iot.id
  rule_number    = 200
  egress         = true
  protocol       = "-1"
  rule_action    = "deny"
  cidr_block     = "10.0.0.0/8"
}

############################################################
# NACL-5 PATIENT
############################################################

resource "aws_network_acl" "patient" {
  vpc_id     = var.main_vpc_id
  subnet_ids = var.patient_subnet_ids

  tags = merge(var.tags, {
    Name = "nacl-patient"
  })
}

resource "aws_network_acl_rule" "patient_out_100" {
  network_acl_id = aws_network_acl.patient.id
  rule_number    = 100
  egress         = true
  protocol       = "6"
  rule_action    = "allow"
  cidr_block     = "0.0.0.0/0"
  from_port      = 443
  to_port        = 443
}

resource "aws_network_acl_rule" "patient_out_110" {
  network_acl_id = aws_network_acl.patient.id
  rule_number    = 110
  egress         = true
  protocol       = "6"
  rule_action    = "allow"
  cidr_block     = "0.0.0.0/0"
  from_port      = 80
  to_port        = 80
}

resource "aws_network_acl_rule" "patient_out_200" {
  network_acl_id = aws_network_acl.patient.id
  rule_number    = 200
  egress         = true
  protocol       = "-1"
  rule_action    = "deny"
  cidr_block     = "10.0.0.0/8"
}