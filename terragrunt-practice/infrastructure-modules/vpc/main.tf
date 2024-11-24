# Creating VPC


resource "aws_vpc" "module-vpc" {
    cidr_block = var.vpc_config.cidr_block
    enable_dns_support = true
    enable_dns_hostnames = true
    tags = merge(
      var.vpc_config.tags, 
      {"Name" = var.env == "" ? var.vpc_config.name : "eks-${var.env}-vpc"}
    )
  
}

# Public Subnets

resource "aws_subnet" "subnet-pub" {
    for_each = { for idx, subnet in var.vpc_config.subnets : subnet.subnet_name => subnet if subnet.subnet_type == "public" }
    vpc_id = aws_vpc.module-vpc.id
    cidr_block = each.value.subnet_cidr
    availability_zone = var.vpc_config.availability_zones[each.key == "public-subnet-1" ? 0 : 1]  # First AZ for the first public subnet, second AZ for the second public subnet
    map_public_ip_on_launch = true
    tags = merge(
      var.public_subnet_tags,
      { "Name" = var.env == "" ? each.key : "eks-${var.env}-${each.key}" }
    )
  
}

# Private Subnets

resource "aws_subnet" "subnet-private" {
    for_each = { for idx, subnet in var.vpc_config.subnets : subnet.subnet_name => subnet if subnet.subnet_type == "private" }
    vpc_id = aws_vpc.module-vpc.id
    cidr_block = each.value.subnet_cidr
    availability_zone = var.vpc_config.availability_zones[each.key == "private-subnet-1" ? 0 : 1]  # First AZ for the first private subnet, second AZ for the second private subnet
    tags = merge(
      var.private_subnet_tags,
      { "Name" = var.env == "" ? each.key : "eks-${var.env}-${each.key}" }
    )
  
}

# Internet Gateway for Public Subnets

resource "aws_internet_gateway" "module-igw" {
    vpc_id = aws_vpc.module-vpc.id
    tags = merge(
      var.vpc_config.tags, 
      {"Name" = var.env == "" ? "igw" : "eks-${var.env}-igw"}
    )
  
}

# Route Table for Public Subnets (direct to IGW)

resource "aws_route_table" "public_route_table" {
    vpc_id = aws_vpc.module-vpc.id
    tags = merge(
      var.vpc_config.tags,
      {"Name" = var.env == "" ? "routetable" : "eks-${var.env}-routetable"}
    )

    route {
        cidr_block = "0.0.0.0/0"
        gateway_id = aws_internet_gateway.module-igw.id
    }
  
}
# Public Route Table Association for Public Subnets

resource "aws_route_table_association" "public_subnet_association" {
  for_each = aws_subnet.subnet-pub
  subnet_id      = each.value.id
  route_table_id = aws_route_table.public_route_table.id
}

