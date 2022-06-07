locals {
  environment = var.environment

  context = {
    environment = local.environment
  }
}

module "network" {
  source  = "../dojo-network"
  context = local.context
}

resource "aws_key_pair" "this" {
  key_name = local.environment
  # ⚠️ Change this 👇, write your public SSH key.
  public_key = ""
}

# module "public_instance" {
#   source   = "../dojo-public-instance"
#   context  = local.context
#   network  = module.network
#   key_name = aws_key_pair.this.key_name
# }

# module "private_instance" {
#   source   = "../dojo-private-instance"
#   context  = local.context
#   network  = module.network
#   key_name = aws_key_pair.this.key_name
# }
