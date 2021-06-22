output "vpc" {
  value = aws_vpc.main.id
}

output "public_subnet" {
  value = aws_subnet.Public-Subnet-main.*.id
}

output "private_subnet" {
  value = aws_subnet.Private-Subnet-main.*.id
}