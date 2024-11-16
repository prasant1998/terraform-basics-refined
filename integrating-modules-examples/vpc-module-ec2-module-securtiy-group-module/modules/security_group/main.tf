resource "aws_security_group" "test-sg" {
    name = var.sg_name
    description = "Security Group connected to an ec2 instance"
    vpc_id = var.vpc_id

    dynamic "ingress" {
        for_each = var.ingress_rules

        content {
          cidr_blocks = [ingress.value.cidr_block]
          to_port = ingress.value.to_port
          from_port = ingress.value.from_port
          protocol = ingress.value.protocol
        }
      
    }

    dynamic "egress" {
        for_each = var.egress_rules

        content {
          cidr_blocks = [egress.value.cidr_block]
          to_port = egress.value.to_port
          from_port = egress.value.from_port
          protocol = egress.value.protocol
        }
      
    }
  
}