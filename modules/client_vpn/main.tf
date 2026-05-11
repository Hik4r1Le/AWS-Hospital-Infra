resource "aws_ec2_client_vpn_endpoint" "client_vpn_endpoint" {
  description            = "Client VPN Endpoint for NT113 Project"
  server_certificate_arn = var.server_cert_arn
  client_cidr_block      = "192.168.100.0/22"

  authentication_options {
    type                       = "certificate-authentication"
    root_certificate_chain_arn = var.client_cert_arn
  }

  connection_log_options {
    enabled               = true
    cloudwatch_log_group  = var.cloudwatch_log_group_name
    cloudwatch_log_stream = var.cloudwatch_log_stream_name
  }
  security_group_ids = var.security_group_ids
  split_tunnel       = true

  tags = {
    Name = "NT113-Project-client-vpn-endpoint"
  }
}

resource "aws_ec2_client_vpn_network_association" "association" {
  count = length(var.subnet_ids)
  client_vpn_endpoint_id = aws_ec2_client_vpn_endpoint.client_vpn_endpoint.id
  subnet_id              = var.subnet_ids[count.index]
}

resource "aws_ec2_client_vpn_authorization_rule" "rule" {
  count = length(var.allow_cidrs)
  client_vpn_endpoint_id = aws_ec2_client_vpn_endpoint.client_vpn_endpoint.id
  target_network_cidr    = var.allow_cidrs[count.index]
  authorize_all_groups   = true
}

resource "aws_ec2_client_vpn_route" "route" {
  client_vpn_endpoint_id = aws_ec2_client_vpn_endpoint.client_vpn_endpoint.id
  destination_cidr_block = "0.0.0.0/0"
  target_vpc_subnet_id   = ""
}