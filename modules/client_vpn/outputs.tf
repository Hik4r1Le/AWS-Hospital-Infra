output "client_vpn_endpoint_id" {
  value = aws_ec2_client_vpn_endpoint.client_vpn_endpoint.id
}

output "client_vpn_endpoint_dns_name" {
  value = aws_ec2_client_vpn_endpoint.client_vpn_endpoint.dns_name  
}
