variable "cluster_name" {
    description = "Name of the Cluster"
    type = string
  
}

variable "node_group_name" {
    description = "Name of the Node Group"
    type = string
    default = "test-node-group"
}

variable "node_group_role_name" {
    description = "Name for the Node Group Role"
    type = string
    default = "test-node-group-role"
  
}

variable "launch_template_name_prefix" {
    description = "Name Prefix for the launch template"
    type = string
    default = "test-node-group-launch-template"
  
}

variable "node_instance_type" {
    description = "Instance type of the Nodes"
    type = string
    default = "t2.micro"
  
}

variable "node_volume_size" {
    description = "Size of the Node Volume"
    type = number
    default = 10
  
}

variable "node_volume_type" {
    description = "Volume type"
    type = string
    default = "gp3"
  
}

variable "required_nodes" {
    description = "The No of Nodes Required"
    type = number
    default = 2
  
}

variable "max_nodes" {
    description = "The maximum no of nodes"
    type = number
    default = 3
  
}

variable "min_nodes" {
    description = "The Minimum no of Nodes "
    type = number
    default = 1
  
}

variable "capacity_type" {
    description = "Nodes Capacity Type "
    type = string
    default = "ON_DEMAND"
  
}

variable "ami_type" {
    description = "AMI Type for the Nodes "
    type = string
    default = "AL2_x86_64"
  
}



variable "tags" {
    description = "Tags to be attached the resources of Node Group"
    type = map(string)
    default = {
      "Name" = "test-node-group"
      "Env"  =  "dev"
      "Owner" =  "DevOps"
    }
  
}

variable "subnet_ids_public" {
    description = "List of Public Subnet Ids"
    type = list(string)
  
}

variable "env" {
    description = "Enviornment for the Infrastructure"
    type = string
  
}
