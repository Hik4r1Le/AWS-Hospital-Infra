output "ec2_his_az1_id" {
  value = aws_instance.his_az1.id
}

output "ec2_his_az2_id" {
  value = aws_instance.his_az2.id
}

output "ec2_his_az1_private_ip" {
  value = aws_instance.his_az1.private_ip
}

output "ec2_his_az2_private_ip" {
  value = aws_instance.his_az2.private_ip
}