output "vpc_id" {
  value = aws_vpc.module-vpc.id
}

output "public_subnet_1_id" {
  value = aws_subnet.module-subnet-pub-1.id
}

output "public_subnet_2_id" {
  value = aws_subnet.module-subnet-pub-2.id
}

output "private_subnet_1_id" {
  value = aws_subnet.module-subnet-priv-1.id
}

output "private_subnet_2_id" {
  value = aws_subnet.module-subnet-priv-2.id
}
