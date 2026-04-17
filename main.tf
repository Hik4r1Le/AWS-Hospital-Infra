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
