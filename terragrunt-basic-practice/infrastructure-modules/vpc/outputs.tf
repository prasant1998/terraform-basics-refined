output "vpc_id" {
  value = aws_vpc.module-vpc.id
}

output "public_subnet_1_id" {
  value = aws_subnet.subnet-pub["public-subnet-1"].id
}

output "public_subnet_2_id" {
  value = aws_subnet.subnet-pub["public-subnet-2"].id
}

output "private_subnet_1_id" {
  value = aws_subnet.subnet-private["private-subnet-1"].id
}

output "private_subnet_2_id" {
  value = aws_subnet.subnet-private["private-subnet-2"].id
}


output "subnet_ids" {
  value = [
    aws_subnet.subnet-pub["public-subnet-1"].id,
    aws_subnet.subnet-pub["public-subnet-2"].id,
    aws_subnet.subnet-private["private-subnet-1"].id,
    aws_subnet.subnet-private["private-subnet-2"].id
  ]
  
}

output "subnet_ids_public" {
  value = [
    aws_subnet.subnet-pub["public-subnet-1"].id,
    aws_subnet.subnet-pub["public-subnet-2"].id
  ]
  
}