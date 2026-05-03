
output "s3_gateway_endpoint_id" {
  value = aws_vpc_endpoint.s3_gateway.id
}

output "ssm_endpoint_id" {
  value = aws_vpc_endpoint.ssm.id
}
