output "eks_node_group_role_arn" {
  value = aws_iam_role.eks_node_group_role.arn
}


output "launch_template_name" {
    value = aws_launch_template.eks_node_template.name
  
}

output "node_group_id" {
  value = aws_eks_node_group.eks_node_group.id
}