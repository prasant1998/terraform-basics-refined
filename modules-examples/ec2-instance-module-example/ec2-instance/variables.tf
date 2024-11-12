variable "instance_type" {
  description = "The type of instance to use"
  type        = string
  default     = "t2.micro"
}

variable "ami_id" {
    description = "The Type of AMI Id to use"
    type = string
    default = "ami-042e76978adeb8c48"
  
}

variable "instance_name" {
  description = "The name of instance to use"
  type        = string
  default     = "module-test"
}
