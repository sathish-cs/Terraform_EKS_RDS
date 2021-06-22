# VPC  

resource "aws_vpc" "main" {
  cidr_block           = var.vpc_cidr
  instance_tenancy     = "default"
  enable_dns_hostnames = true
  enable_dns_support   = true

  tags = {
    Name = "${var.tags}-vpc"
  }
}

#Subnet for Public resources 

resource "aws_subnet" "Public-Subnet-main" {
  vpc_id                  = aws_vpc.main.id
  count                   = length(var.public_cidr)
  availability_zone       = element(var.avail_zone, count.index)
  cidr_block              = element(var.public_cidr, count.index)
  map_public_ip_on_launch = "true"

  tags = {
    Name = element(var.public_subnet_names, count.index)
  }
}

#Subnet for Private servers 

resource "aws_subnet" "Private-Subnet-main" {
  vpc_id                  = aws_vpc.main.id
  count                   = length(var.private_cidr)
  availability_zone       = element(var.avail_zone, count.index)
  cidr_block              = element(var.private_cidr, count.index)
  map_public_ip_on_launch = "true"

  tags = {
    Name = element(var.private_subnet_names, count.index)
  }
}

#Internet Gateway 

resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.main.id

  tags = {
    Name = "${var.tags}-Internet-gateway"
  }
}

#Elastic IP for NAT Gateway 

resource "aws_eip" "ip" {
  vpc = true

  tags = {
    Name = "${var.tags}-NAT-EIP"
  }
}

#NAT Gateway

resource "aws_nat_gateway" "ngw" {
  #count = 1
  allocation_id = aws_eip.ip.id
  subnet_id     = element(aws_subnet.Public-Subnet-main.*.id, 0)

  tags = {
    Name = "${var.tags}-Nat-gateway"
  }
}

#Route table for public subnets 

resource "aws_route_table" "main" {
  vpc_id = aws_vpc.main.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw.id
  }

  tags = {
    Name = "${var.tags}-Public-Route"
  }
}

#Route table for private subnets 

resource "aws_route_table" "main-ngw" {
  vpc_id = aws_vpc.main.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_nat_gateway.ngw.id
  }
  tags = {
    Name = "${var.tags}-Private-Route"
  }
}

#Attaching subnets with Route tables 
resource "aws_route_table_association" "public" {
  count          = length(var.public_cidr)
  subnet_id      = element(aws_subnet.Public-Subnet-main.*.id, count.index)
  route_table_id = aws_route_table.main.id
}

resource "aws_route_table_association" "private" {
  count          = length(var.private_cidr)
  subnet_id      = element(aws_subnet.Private-Subnet-main.*.id, count.index)
  route_table_id = aws_route_table.main.id
}