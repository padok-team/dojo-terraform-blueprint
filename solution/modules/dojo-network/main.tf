locals {
  environment = var.context.environment

  vpc_id_by_environment = {
    dojo = "vpc-0f86c370775139b60"
  }
  public_cidr_by_environment = {
    dojo = "172.16.10.0/24"
  }
  private_cidr_by_environment = {
    dojo = "172.16.15.0/24"
  }
  internet_gateway_id_by_environment = {
    dojo = "igw-004326a54df37ec99"
  }
  route_table_id_by_environment = {
    dojo = "rtb-06dcab00c2455ec07"
  }

  vpc_id       = local.vpc_id_by_environment[local.environment]
  public_cidr  = local.public_cidr_by_environment[local.environment]
  private_cidr = local.private_cidr_by_environment[local.environment]
  internet_gateway_id = local.internet_gateway_id_by_environment[local.environment]
  route_table_id = local.route_table_id_by_environment[local.environment]
}

data "aws_vpc" "this" {
  id = local.vpc_id
}

resource "aws_subnet" "private" {
  vpc_id            = data.aws_vpc.this.id
  availability_zone = "eu-west-3a"

  cidr_block = local.private_cidr

  tags = {
    Name = local.environment
  }
}

resource "aws_subnet" "public" {
  vpc_id            = data.aws_vpc.this.id
  availability_zone = "eu-west-3a"

  cidr_block = local.public_cidr

  tags = {
    Name = local.environment
  }
}

data "aws_internet_gateway" "this" {
  internet_gateway_id = local.internet_gateway_id
}

data "aws_route_table" "public" {
  route_table_id = local.route_table_id
}

resource "aws_route_table_association" "public" {
  subnet_id      = aws_subnet.public.id
  route_table_id = data.aws_route_table.public.id
}

resource "aws_eip" "nat" {
  vpc = true
}

resource "aws_nat_gateway" "this" {
  allocation_id = aws_eip.nat.id
  subnet_id     = aws_subnet.public.id

  tags = {
    Name = local.environment
  }
}

resource "aws_route_table" "private" {
  vpc_id = data.aws_vpc.this.id

  route {
    cidr_block     = "0.0.0.0/0" # Internet
    nat_gateway_id = aws_nat_gateway.this.id
  }
}

resource "aws_route_table_association" "private" {
  subnet_id      = aws_subnet.private.id
  route_table_id = aws_route_table.private.id
}
