#################################################
# Get latest Amazon Linux 2023
#################################################

data "aws_ami" "amazon_linux_2023" {
  most_recent = true
  owners      = ["137112412989"]

  filter {
    name   = "name"
    values = ["al2023-ami-2023*kernel-6.1-x86_64"]
  }
}

#################################################
# EC2 AZ1
#################################################

resource "aws_instance" "his_az1" {
  ami                    = data.aws_ami.amazon_linux_2023.id
  instance_type          = var.instance_type
  subnet_id              = var.private_clinical_az1_id
  vpc_security_group_ids = [var.sg_ec2_his_id]

  iam_instance_profile = var.iam_instance_profile_name

  associate_public_ip_address = false

  user_data = file("${path.module}/user_data.sh")

  root_block_device {
    volume_size = 20
    volume_type = "gp3"
    encrypted   = true
    kms_key_id  = var.kms_ebs_key_arn
  }

  tags = merge(var.tags, {
    Name = "ec2-his-app-az1"
  })
}

#################################################
# EC2 AZ2
#################################################

resource "aws_instance" "his_az2" {
  ami                    = data.aws_ami.amazon_linux_2023.id
  instance_type          = var.instance_type
  subnet_id              = var.private_clinical_az2_id
  vpc_security_group_ids = [var.sg_ec2_his_id]

  iam_instance_profile = var.iam_instance_profile_name

  associate_public_ip_address = false

  user_data = file("${path.module}/user_data.sh")

  root_block_device {
    volume_size = 20
    volume_type = "gp3"
    encrypted   = true
    kms_key_id  = var.kms_ebs_key_arn
  }

  tags = merge(var.tags, {
    Name = "ec2-his-app-az2"
  })
}