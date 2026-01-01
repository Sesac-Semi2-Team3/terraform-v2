################################
# VPC
################################
resource "aws_vpc" "this" {
  cidr_block           = var.vpc_cidr
  enable_dns_support   = true
  enable_dns_hostnames = true

  tags = {
    Name = "${var.project_name}-vpc"
  }
}

################################
# Internet Gateway
################################
resource "aws_internet_gateway" "this" {
  vpc_id = aws_vpc.this.id

  tags = {
    Name = "${var.project_name}-igw"
  }
}

################################
# Public Subnets
################################
resource "aws_subnet" "public" {
  for_each = var.public_subnets

  vpc_id                  = aws_vpc.this.id
  cidr_block              = each.value.cidr
  availability_zone       = each.value.az
  map_public_ip_on_launch = true

  tags = {
    Name = "${var.project_name}-public-${each.key}"
  }
}

################################
# NAT Gateway (Single NAT)
################################

data "aws_nat_gateway" "this" {
  count = var.use_existing_nat_gateway ? 1 : 0
  id    = var.existing_nat_gateway_id
}

locals {
  nat_gateway_id = var.use_existing_nat_gateway ? data.aws_nat_gateway.this[0].id : null
}


################################
# Private Subnets (App)
################################
resource "aws_subnet" "private" {
  for_each = var.private_subnets

  vpc_id            = aws_vpc.this.id
  cidr_block        = each.value.cidr
  availability_zone = each.value.az

  tags = {
    Name = "${var.project_name}-private-${each.key}"
  }
}

################################
# RDS Subnets (DB 전용)
################################
resource "aws_subnet" "rds" {
  for_each = var.rds_subnets

  vpc_id            = aws_vpc.this.id
  cidr_block        = each.value.cidr
  availability_zone = each.value.az

  tags = {
    Name = "${var.project_name}-rds-${each.key}"
  }
}

################################
# Route Tables
################################
resource "aws_route_table" "public" {
  vpc_id = aws_vpc.this.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.this.id
  }

  tags = {
    Name = "${var.project_name}-public-rt"
  }
}

resource "aws_route_table" "private" {
  vpc_id = aws_vpc.this.id

  dynamic "route" {
    for_each = var.use_existing_nat_gateway ? [1] : []
    content {
      cidr_block     = "0.0.0.0/0"
      nat_gateway_id = local.nat_gateway_id
    }
  }
}


resource "aws_route_table" "rds" {
  vpc_id = aws_vpc.this.id

  tags = {
    Name = "${var.project_name}-rds-rt"
  }
}

################################
# Route Table Associations
################################
resource "aws_route_table_association" "public" {
  for_each = var.public_subnets

  subnet_id      = aws_subnet.public[each.key].id
  route_table_id = aws_route_table.public.id
}

resource "aws_route_table_association" "private" {
  for_each = var.private_subnets

  subnet_id      = aws_subnet.private[each.key].id
  route_table_id = aws_route_table.private.id
}

resource "aws_route_table_association" "rds" {
  for_each = var.rds_subnets

  subnet_id      = aws_subnet.rds[each.key].id
  route_table_id = aws_route_table.rds.id
}
