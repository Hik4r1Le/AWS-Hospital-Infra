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