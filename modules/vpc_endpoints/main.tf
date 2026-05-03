data "aws_region" "current" {}

#####################################################
# S3 Gateway Endpoint (miễn phí, không qua internet)
# Tự động inject prefix list vào route tables chỉ định
#####################################################

resource "aws_vpc_endpoint" "s3_gateway" {
  vpc_id            = var.main_vpc_id
  service_name      = "com.amazonaws.${data.aws_region.current.name}.s3"
  vpc_endpoint_type = "Gateway"

  route_table_ids = var.s3_gateway_route_table_ids

  tags = merge(var.tags, {
    Name = "vpce-s3-gateway-main-hospital"
  })
}

#####################################################
# SSM Interface Endpoints (cần đủ 3 endpoints)
# com.amazonaws.<region>.ssm
# com.amazonaws.<region>.ssmmessages
# com.amazonaws.<region>.ec2messages
#####################################################

resource "aws_vpc_endpoint" "ssm" {
  vpc_id              = var.main_vpc_id
  service_name        = "com.amazonaws.${data.aws_region.current.name}.ssm"
  vpc_endpoint_type   = "Interface"
  subnet_ids          = var.ssm_subnet_ids
  security_group_ids  = [var.sg_vpce_ssm_id]
  private_dns_enabled = true

  tags = merge(var.tags, {
    Name = "vpce-ssm-main-hospital"
  })
}

resource "aws_vpc_endpoint" "ssmmessages" {
  vpc_id              = var.main_vpc_id
  service_name        = "com.amazonaws.${data.aws_region.current.name}.ssmmessages"
  vpc_endpoint_type   = "Interface"
  subnet_ids          = var.ssm_subnet_ids
  security_group_ids  = [var.sg_vpce_ssm_id]
  private_dns_enabled = true

  tags = merge(var.tags, {
    Name = "vpce-ssmmessages-main-hospital"
  })
}

resource "aws_vpc_endpoint" "ec2messages" {
  vpc_id              = var.main_vpc_id
  service_name        = "com.amazonaws.${data.aws_region.current.name}.ec2messages"
  vpc_endpoint_type   = "Interface"
  subnet_ids          = var.ssm_subnet_ids
  security_group_ids  = [var.sg_vpce_ssm_id]
  private_dns_enabled = true

  tags = merge(var.tags, {
    Name = "vpce-ec2messages-main-hospital"
  })
}
