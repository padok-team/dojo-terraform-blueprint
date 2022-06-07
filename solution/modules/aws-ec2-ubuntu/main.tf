data "aws_ami" "ubuntu" {
  most_recent = true

  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-focal-20.04-amd64-server-*"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }

  owners = ["099720109477"] # Canonical
}

resource "aws_instance" "this" {
  ami           = data.aws_ami.ubuntu.id
  instance_type = "t3.micro"

  private_ip                  = var.private_ip
  associate_public_ip_address = var.is_public
  key_name                    = var.key_name

  vpc_security_group_ids = [
    aws_security_group.this.id
  ]
  subnet_id = var.subnet.id
  tags = {
    Name = var.name
  }

  depends_on = [var.internet_gateway]
}

resource "aws_security_group" "this" {
  name   = var.name
  vpc_id = var.vpc.id

  # Allow SSH
  dynamic "ingress" {
    for_each = var.ingress

    content {
      from_port   = ingress.value.from_port
      to_port     = ingress.value.to_port
      protocol    = ingress.value.protocol
      cidr_blocks = ingress.value.cidr_blocks
    }
  }

  # Allow all outbound
  dynamic "egress" {
    for_each = var.egress

    content {
      from_port   = egress.value.from_port
      to_port     = egress.value.to_port
      protocol    = egress.value.protocol
      cidr_blocks = egress.value.cidr_blocks
    }
  }
}
