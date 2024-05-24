resource "aws_vpc" "vpc" {
  cidr_block = var.vpc_cidr_block
  enable_dns_hostnames = true
  enable_dns_support = true
  tags = {
    Name = "${var.vpc_name}-${var.vpc_region}"
  }
}

resource "aws_subnet" "public_subnets" {
  vpc_id = aws_vpc.vpc.id
  count = length(var.vpc_public_subnets)
  cidr_block = element(var.vpc_public_subnets, count.index)
  availability_zone = element(var.azs, count.index)
  map_public_ip_on_launch = true
  tags = {
    Name = "${var.vpc_name}-Public-Subnet"
  } 
}

resource "aws_subnet" "private_subnets" {
  vpc_id = aws_vpc.vpc.id
  count = length(var.vpc_private_subnets)
  cidr_block = element(var.vpc_private_subnets, count.index)
  availability_zone = element(var.azs, count.index)

  tags = {
    Name = "${var.vpc_name}-Private-Subnet"
  }
}

resource "aws_internet_gateway" "vpc_igw" {
  vpc_id = aws_vpc.vpc.id
  tags = {
    Name = "${var.vpc_name}-Internet-Gateway"
  }
}


resource "aws_eip" "nat_eip" {
  domain = "vpc"
  depends_on = [ aws_internet_gateway.vpc_igw ]
}


resource "aws_nat_gateway" "nat_gateway" {
  allocation_id = aws_eip.nat_eip.id
  subnet_id = element(aws_subnet.public_subnets.*.id, 0)
  tags = {
    Name = "${var.vpc_name}-Nat-Gateway"
  }
}


resource "aws_route_table" "public_route_table" {
  vpc_id = aws_vpc.vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.vpc_igw.id
  }


  tags = {
    Name = "${var.vpc_name}-Public-Route-Table"
  }
}

resource "aws_route_table_association" "associate_public_subnet" {
  count = length(var.vpc_public_subnets)
  subnet_id = element(aws_subnet.public_subnets[*].id, count.index)
  route_table_id = aws_route_table.public_route_table.id
}


resource "aws_route_table" "private_route_table" {
  vpc_id = aws_vpc.vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.nat_gateway.id
  }
  tags = {
      Name = "${var.vpc_name}-Private-Route-Table"
  }
}

resource "aws_route_table_association" "associate_private_subnet" {
  count = length(var.vpc_private_subnets)
  subnet_id = element(aws_subnet.private_subnets[*].id, count.index)
  route_table_id = aws_route_table.private_route_table.id
}
