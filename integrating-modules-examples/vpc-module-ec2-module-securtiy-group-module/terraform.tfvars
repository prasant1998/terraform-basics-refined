vpc_name = "my-test-vpc"
vpc_cidr = "192.168.0.0/16"

azs = ["ap-northeast-2a", "ap-northeast-2c"]
public_subnets_cidr = ["192.168.101.0/24", "192.168.102.0/24"]
private_subnets_cidr = ["192.168.201.0/24", "192.168.202.0/24"]


sg_name = "myvpc"


ami_id = "ami-042e76978adeb8c48"
instance_type = "t2.micro"