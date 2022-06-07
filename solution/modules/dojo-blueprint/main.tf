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
  key_name   = local.environment
  public_key = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQDLOH85Y5tVt9seXJa+3rMd/7+27+qqRY7oGZ+NPJ1tMlGllYSs9P2xXWdUKQPfpHoK51OldX3ijO8SPn4nmUj+WcQlZsiK7ejj/j9ukabgnCp70u9JNvWrhFuMkRqiM05LiusMJiR6HDUi1gUJRrw/jOba0sqrHassriS6L8uxDLRK3FDwRbqFqAo3Vwf9pHv8wykb2g/FzTOkN+wjiGC0hqfUSpqzrD0/Ac/hMHzrytmBGoSMUnse8kS9Sg2sLsaGUs2tyDpxqqjQXdBpU9QhOiOMQGqqlVH3FQbagSAOcnPbE2cFyCKG8O1roMZefvRkTCYaexA40YloMgkiAmr3 sacha@alabastionette"
}

module "public_instance" {
  source   = "../dojo-public-instance"
  context  = local.context
  network  = module.network
  key_name = aws_key_pair.this.key_name
}

module "private_instance" {
  source   = "../dojo-private-instance"
  context  = local.context
  network  = module.network
  key_name = aws_key_pair.this.key_name
}
