output "vpc" {
  value = data.aws_vpc.this
}

output "internet_gateway" {
  value = aws_internet_gateway.this
}

output "public_subnet" {
  value = aws_subnet.public
}

output "private_subnet" {
  value = aws_subnet.private
}
