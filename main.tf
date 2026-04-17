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