resource "aws_iam_role" "eks_node_group_role" {
  name = var.env == "" ? var.node_group_role_name : "eks-${var.env}-node-group-role"

  assume_role_policy = <<POLICY
  {
    "Version" : "2012-10-17",
    "Statement" : [
        {
            "Effect" : "Allow",
            "Principal" : {
                "Service" : "ec2.amazonaws.com"
            },
            "Action" : "sts:AssumeRole"
        }
    ]
  }
POLICY
}

# Attach AmazonEKSWorkerNodePolicy
resource "aws_iam_role_policy_attachment" "eks_worker_node_policy" {
  role       = aws_iam_role.eks_node_group_role.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSWorkerNodePolicy"
}

# Attach AmazonEC2ContainerRegistryReadOnly
resource "aws_iam_role_policy_attachment" "eks_container_registry_policy" {
  role       = aws_iam_role.eks_node_group_role.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonEC2ContainerRegistryReadOnly"
}

# Attach AmazonEKS_CNI_Policy
resource "aws_iam_role_policy_attachment" "eks_cni_policy" {
  role       = aws_iam_role.eks_node_group_role.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKS_CNI_Policy"
}

# # Attach custom policy (optional, for additional permissions)
# resource "aws_iam_policy" "custom_node_policy" {
#   name        = "custom-node-policy"
#   description = "Custom permissions for EKS node group"

#   policy = jsonencode({
#     Version = "2012-10-17"
#     Statement = [
#       {
#         Effect   = "Allow"
#         Action   = [
#           "autoscaling:DescribeAutoScalingGroups",
#           "autoscaling:DescribeAutoScalingInstances",
#           "autoscaling:DescribeLaunchConfigurations",
#           "autoscaling:DescribeTags"
#         ]
#         Resource = "*"
#       }
#     ]
#   })
# }

resource "aws_launch_template" "eks_node_template" {
    name_prefix = var.env == "" ? var.launch_template_name_prefix : "eks-${var.env}-${var.launch_template_name_prefix}"
    instance_type = var.node_instance_type

    block_device_mappings {
      device_name = "/dev/xvda"  
      ebs {
        volume_size =  var.node_volume_size
        volume_type = var.node_volume_type
        delete_on_termination = true
        encrypted = true
      }
    }
    tags = merge(
        var.tags, 
        {"Name" = var.env == "" ? "node-group-launch-template" : "eks-${var.env}-node-group-launch-template"}
    ) 
  
}


resource "aws_eks_node_group" "eks_node_group" {
    cluster_name = var.cluster_name
    node_group_name = var.env == "" ? var.node_group_name : "eks-${var.env}-${var.node_group_name}"
    node_role_arn = aws_iam_role.eks_node_group_role.arn

    subnet_ids = var.subnet_ids_public
    scaling_config {
      desired_size = var.required_nodes
      max_size = var.max_nodes
      min_size = var.min_nodes
    }

    update_config {
      max_unavailable = 1
    }

    capacity_type = var.capacity_type
    force_update_version = false
    ami_type = var.ami_type

    tags = merge(
        var.tags, 
        {"Name" = var.env == "" ? var.node_group_name : "eks-${var.env}-${var.node_group_name}"}
    ) 

    labels = {
      role = "eks-nodes"
    }

    launch_template {
      id = aws_launch_template.eks_node_template.id
      version = "$Latest"
    }

    depends_on = [ 
        aws_iam_role_policy_attachment.eks_cni_policy,
        aws_iam_role_policy_attachment.eks_worker_node_policy,
        aws_iam_role_policy_attachment.eks_container_registry_policy
     ]

}


