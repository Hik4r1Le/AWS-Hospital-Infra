module "kms" {
  source = "./modules/kms"

  iam_user_list = var.iam_user_list
}

module "vpc" {
  source = "./modules/vpc"
}

module "subnets" {
  source = "./modules/subnets"

  main_vpc_id      = module.vpc.main_vpc_id
  satellite_vpc_id = module.vpc.satellite_vpc_id
}

module "igw" {
  source = "./modules/igw"

  main_vpc_id      = module.vpc.main_vpc_id
  satellite_vpc_id = module.vpc.satellite_vpc_id

  tags = local.common_tags
}

module "eip" {
  source = "./modules/eip"

  tags = local.common_tags
}

module "nat_gateway" {
  source = "./modules/nat_gateway"

  public_az1_subnet_id        = module.subnets.public_az1_subnet_id
  public_az2_subnet_id        = module.subnets.public_az2_subnet_id
  satellite_public_subnet_id  = module.subnets.satellite_public_subnet_id

  eip_nat_main_az1_id = module.eip.eip_nat_main_az1_id
  eip_nat_main_az2_id = module.eip.eip_nat_main_az2_id
  eip_nat_satellite_id = module.eip.eip_nat_satellite_id

  main_igw_id      = module.igw.main_igw_id
  satellite_igw_id = module.igw.satellite_igw_id

  tags = local.common_tags
}

module "security_groups" {
  source = "./modules/security_groups"

  main_vpc_id = module.vpc.main_vpc_id

  vpn_client_cidr      = "192.168.100.0/22"
  staff_main_cidr      = "10.0.20.0/24"
  staff_satellite_cidr = "10.1.10.0/24"
  patient_cidr         = "10.0.30.0/24"
  iot_cidr             = "10.0.40.0/24"

  tags = local.common_tags
}

module "nacl" {
  source = "./modules/nacl"

  main_vpc_id      = module.vpc.main_vpc_id
  satellite_vpc_id = module.vpc.satellite_vpc_id

  public_subnet_ids = [
    module.subnets.public_az1_subnet_id,
    module.subnets.public_az2_subnet_id
  ]

  clinical_subnet_ids = [
    module.subnets.private_clinical_az1_id,
    module.subnets.private_clinical_az2_id
  ]

  staff_main_subnet_ids = [
    module.subnets.private_staff_az1_id
  ]

  iot_subnet_ids = [
    module.subnets.private_iot_az1_id
  ]

  patient_subnet_ids = [
    module.subnets.private_patient_az1_id
  ]

  vpn_client_cidr      = "192.168.100.0/22"
  staff_satellite_cidr = "10.1.10.0/24"
  patient_cidr         = "10.0.30.0/24"
  iot_cidr             = "10.0.40.0/24"

  tags = local.common_tags
}

module "ec2" {
  source = "./modules/ec2"

  instance_type = "t3.small"

  private_clinical_az1_id = module.subnets.private_clinical_az1_id
  private_clinical_az2_id = module.subnets.private_clinical_az2_id

  sg_ec2_his_id = module.security_groups.sg_ec2_his_id

  iam_instance_profile_name = module.iam.role_ec2_his_profile_name

  kms_ebs_key_arn = module.kms.ebs_key_arn

  tags = local.common_tags
}

module "vpc_flow_logs" {
  source = "./modules/vpc_flow_logs"

  main_vpc_id      = module.vpc.main_vpc_id
  satellite_vpc_id = module.vpc.satellite_vpc_id

  flow_logs_role_arn = module.iam.role_vpc_flow_logs_arn

  main_log_group_name      = "/aws/vpc/main-hospital-flowlogs"
  satellite_log_group_name = "/aws/vpc/satellite-flowlogs"

  tags = local.common_tags
}

module "cloudwatch" {
  source = "./modules/cloudwatch"

  alb_arn_suffix = module.alb.alb_arn_suffix

  ec2_his_az1_id = module.ec2.ec2_his_az1_id
  ec2_his_az2_id = module.ec2.ec2_his_az2_id

  rds_instance_id = module.rds.rds_instance_id

  vpn_endpoint_id = module.client_vpn.vpn_endpoint_id

  sns_alarm_email = "youremail@gmail.com"

  tags = local.common_tags
}
module "s3" {
  source = "./modules/s3"

  kms_s3_key_arn = module.kms.s3_key_arn

  tags = local.common_tags
}

module "vpc_endpoints" {
  source = "./modules/vpc_endpoints"

  main_vpc_id = module.vpc.main_vpc_id

  s3_gateway_route_table_ids = [
    module.route_tables.rt_clinical_az1_id,
    module.route_tables.rt_clinical_az2_id,
    module.route_tables.rt_private_az1_id,
  ]

  ssm_subnet_ids = [
    module.subnets.private_clinical_az1_id,
    module.subnets.private_clinical_az2_id,
  ]

  sg_vpce_ssm_id = module.security_groups.sg_vpce_ssm_id

  tags = local.common_tags
}

module "guardduty" {
  source = "./modules/guardduty"

  cloudtrail_bucket_arn = module.s3.cloudtrail_bucket_arn
  kms_s3_key_arn        = module.kms.s3_key_arn

  tags = local.common_tags
}

module "route53" {
  source = "./modules/route53"

  main_vpc_id         = module.vpc.main_vpc_id
  private_domain_name = "hospital.internal"

  alb_dns_name = module.alb.alb_dns_name
  alb_zone_id  = module.alb.alb_zone_id
  rds_endpoint = module.rds.rds_endpoint

  tags = local.common_tags
}

module "cloudtrail" {
  source = "./modules/cloudtrail"

  cloudtrail_bucket_id     = module.s3.cloudtrail_bucket_id
  cloudtrail_log_group_arn = module.cloudwatch.cloudtrail_log_group_arn
  kms_s3_key_arn           = module.kms.s3_key_arn

  tags = local.common_tags
}
