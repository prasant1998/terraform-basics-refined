resource "aws_vpc" "module-vpc" {
    cidr_block = var.cidr_block
    enable_dns_support = true
    enable_dns_hostnames = true
    tags = {
      "Name" = var.vpc_name
    }
  
}

resource "aws_subnet" "module-subnet-pub-1" {
    vpc_id = aws_vpc.module-vpc.id
    cidr_block = var.public_subnet_1_cidr
    availability_zone = var.availability_zone_1
    map_public_ip_on_launch = true
    tags = {
      "Name" = "${var.vpc_name}-public-subnet-1"
    }
  
}

resource "aws_subnet" "module-subnet-pub-2" {
    vpc_id = aws_vpc.module-vpc.id
    cidr_block = var.public_subnet_2_cidr
    availability_zone = var.availability_zone_2
    map_public_ip_on_launch = true
    tags = {
      "Name" = "${var.vpc_name}-public-subnet-2"
    }
  
}

resource "aws_subnet" "module-subnet-priv-1" {
    vpc_id = aws_vpc.module-vpc.id
    cidr_block = var.private_subnet_1_cidr
    availability_zone = var.availability_zone_1
    tags = {
      "Name" = "${var.vpc_name}-private-subnet-1"
    }
  
}

resource "aws_subnet" "module-subnet-priv-2" {
    vpc_id = aws_vpc.module-vpc.id
    cidr_block = var.private_subnet_2_cidr
    availability_zone = var.availability_zone_2
    tags = {
      "Name" = "${var.vpc_name}-private-subnet-2"
    }
  
}

# Internet Gateway for Public Subnets

resource "aws_internet_gateway" "module-igw" {
    vpc_id = aws_vpc.module-vpc.id
    tags = {
      "Name" = "${var.vpc_name}-igw"
    }
  
}

## NAT Gateway for Private Subnets (optional)
# resource "aws_nat_gateway" "nat_gateway_1" {
#   allocation_id = aws_eip.nat_eip_1.id
#   subnet_id     = aws_subnet.public_subnet_1.id
#   depends_on    = [aws_internet_gateway.igw]
# }

# resource "aws_nat_gateway" "nat_gateway_2" {
#   allocation_id = aws_eip.nat_eip_2.id
#   subnet_id     = aws_subnet.public_subnet_2.id
#   depends_on    = [aws_internet_gateway.igw]
# }

# # Elastic IP for NAT Gateway 1
# resource "aws_eip" "nat_eip_1" {
#   vpc = true
# }

# # Elastic IP for NAT Gateway 2
# resource "aws_eip" "nat_eip_2" {
#   vpc = true
# }

# Route Table for Public Subnets (direct to IGW)

resource "aws_route_table" "public_route_table" {
    vpc_id = aws_vpc.module-vpc.id

    route {
        cidr_block = "0.0.0.0/0"
        gateway_id = aws_internet_gateway.module-igw.id
    }
  
}

# Route Table Association for Public Subnets
resource "aws_route_table_association" "public_subnet_1_association" {
  subnet_id      = aws_subnet.module-subnet-pub-1.id
  route_table_id = aws_route_table.public_route_table.id
}

resource "aws_route_table_association" "public_subnet_2_association" {
  subnet_id      = aws_subnet.module-subnet-pub-2.id
  route_table_id = aws_route_table.public_route_table.id
}

# # Route Table for Private Subnets (direct to NAT Gateway)
# resource "aws_route_table" "private_route_table" {
#   vpc_id = aws_vpc.main.id

#   route {
#     cidr_block = "0.0.0.0/0"
#     nat_gateway_id = aws_nat_gateway.nat_gateway_1.id
#   }
# }

# # Route Table Association for Private Subnets
# resource "aws_route_table_association" "private_subnet_1_association" {
#   subnet_id      = aws_subnet.private_subnet_1.id
#   route_table_id = aws_route_table.private_route_table.id
# }

# resource "aws_route_table_association" "private_subnet_2_association" {
#   subnet_id      = aws_subnet.private_subnet_2.id
#   route_table_id = aws_route_table.private_route_table.id
# }