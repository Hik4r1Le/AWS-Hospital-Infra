module "kms" {
  source = "./modules/kms"

  iam_user_list = var.iam_user_list
}