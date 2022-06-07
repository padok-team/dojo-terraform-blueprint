locals {
  environment = var.context.environment

  vpc_id_by_environment = {
    # ⚠️ Change this 👇, write your unique environment name and the given VPC ID.
    dojo = "vpc-0f86c370775139b60"
  }
  public_cidr_by_environment = {
    # ⚠️ Change this 👇, write your unique environment name and the given CIDR.
    dojo = "172.16.10.0/24"
  }
  private_cidr_by_environment = {
    # ⚠️ Change this 👇, write your unique environment name and the given CIDR.
    dojo = "172.16.15.0/24"
  }

  vpc_id       = local.vpc_id_by_environment[local.environment]
  public_cidr  = local.public_cidr_by_environment[local.environment]
  private_cidr = local.private_cidr_by_environment[local.environment]
}
