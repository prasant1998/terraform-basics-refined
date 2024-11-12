resource "aws_vpc" "module-vpc" {
    cidr_block = var.vpc_config.cidr_block
    enable_dns_support = true
    enable_dns_hostnames = true
    tags = var.vpc_config.tags
  
}

resource "aws_subnet" "subnet-pub" {
    for_each = { for idx, subnet in var.vpc_config.subnets : subnet.subnet_name => subnet if subnet.subnet_type == "public" }
    vpc_id = aws_vpc.module-vpc.id
    cidr_block = each.value.subnet_cidr
    availability_zone = var.vpc_config.availability_zones[each.key == "public-subnet-1" ? 0 : 1]  # First AZ for the first public subnet, second AZ for the second public subnet
    map_public_ip_on_launch = true
    tags = merge(
      var.vpc_config.tags, 
      { "Name" = each.value.subnet_name }
    )
  
}

resource "aws_subnet" "subnet-private" {
    for_each = { for idx, subnet in var.vpc_config.subnets : subnet.subnet_name => subnet if subnet.subnet_type == "private" }
    vpc_id = aws_vpc.module-vpc.id
    cidr_block = each.value.subnet_cidr
    availability_zone = var.vpc_config.availability_zones[each.key == "private-subnet-1" ? 0 : 1]  # First AZ for the first private subnet, second AZ for the second private subnet
    tags = merge(
      var.vpc_config.tags, 
      {"Name" = each.value.subnet_name}
    )
  
}

# Internet Gateway for Public Subnets

resource "aws_internet_gateway" "module-igw" {
    vpc_id = aws_vpc.module-vpc.id
    tags = merge(
      var.vpc_config.tags, 
      {"Name" = "test-igw"}
    )
  
}

# Route Table for Public Subnets (direct to IGW)

resource "aws_route_table" "public_route_table" {
    vpc_id = aws_vpc.module-vpc.id
    tags = merge(
      var.vpc_config.tags, 
      {"Name" = "test-routetable"}
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








## Private Route Table Association for Private Subnets

# resource "aws_route_table" "private" {
#   vpc_id = aws_vpc.module-vpc.id
#   tags   = merge(var.vpc_config.tags, { "Name" = "private-route-table" })
# }

# # Associate the private route table with each private subnet
# resource "aws_route_table_association" "private_subnet_associations" {
#   for_each       = aws_subnet.subnet-private
#   subnet_id      = each.value.id
#   route_table_id = aws_route_table.private.id
# }