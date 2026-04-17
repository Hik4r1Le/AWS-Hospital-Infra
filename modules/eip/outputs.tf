output "eip_nat_main_az1_id" {
  value = aws_eip.nat_main_az1.id
}

output "eip_nat_main_az2_id" {
  value = aws_eip.nat_main_az2.id
}

output "eip_nat_satellite_id" {
  value = aws_eip.nat_satellite.id
}

output "eip_nat_main_az1_public_ip" {
  value = aws_eip.nat_main_az1.public_ip
}

output "eip_nat_main_az2_public_ip" {
  value = aws_eip.nat_main_az2.public_ip
}

output "eip_nat_satellite_public_ip" {
  value = aws_eip.nat_satellite.public_ip
}