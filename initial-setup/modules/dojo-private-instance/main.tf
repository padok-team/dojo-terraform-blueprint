locals {
  environment = var.context.environment

  name = "${local.environment}-private"

  private_ip_by_environment = {
    # ⚠️ Change this 👇, write your unique environment name and the private IP you have chosen.
    dojo = "172.16.15.100"
  }

  private_ip = local.private_ip_by_environment[local.environment]
}

module "this" {
  source = "../aws-ec2-ubuntu"

  is_public = true

  name       = local.name
  private_ip = local.private_ip

  subnet           = var.network.public_subnet
  internet_gateway = var.network.internet_gateway
  vpc              = var.network.vpc

  key_name = var.key_name
}
