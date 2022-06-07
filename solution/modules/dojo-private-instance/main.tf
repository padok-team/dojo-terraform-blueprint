locals {
  environment = var.context.environment

  vpc_cidr_block = var.network.vpc.cidr_block

  name = "${local.environment}-private"

  private_ip_by_environment = {
    dojo = "172.16.15.100"
  }
  ingress_by_environment = {
    dojo = [{
      from_port   = 22
      to_port     = 22
      protocol    = "tcp"
      cidr_blocks = [local.vpc_cidr_block]
      },
      {
        from_port   = 8000
        to_port     = 8000
        protocol    = "tcp"
        cidr_blocks = [local.vpc_cidr_block]
    }]
  }
  egress_by_environment = {
    dojo = [{
      from_port   = 0
      to_port     = 0
      protocol    = "-1"
      cidr_blocks = ["0.0.0.0/0"]
    }]
  }

  private_ip = local.private_ip_by_environment[local.environment]
  ingress    = local.ingress_by_environment[local.environment]
  egress     = local.egress_by_environment[local.environment]
}

module "this" {
  source = "../aws-ec2-ubuntu"

  is_public = true

  name       = local.name
  private_ip = local.private_ip

  subnet           = var.network.private_subnet
  internet_gateway = var.network.internet_gateway
  vpc              = var.network.vpc
  ingress          = local.ingress
  egress           = local.egress

  key_name = var.key_name
}
