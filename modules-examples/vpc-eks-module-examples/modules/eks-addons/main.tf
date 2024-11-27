terraform {
    required_version = ">= 1.5.0"

    required_providers {
        helm = {
            source = "hashicorp/helm"
            version = "2.11.0"
        }
    }
}


# Cluster Autoscaler

data "aws_iam_openid_connect_provider" "eks_oidc_provider" {
    arn = var.oidc_provider_arn
}

data "aws_iam_policy_document" "cluster_autoscaler" {
    statement {
        actions = ["sts:AssumeRole"]
        effect = "Allow"
        
        condition {
            test = "StringEquals"
            variable = "${replace(data.aws_iam_openid_connect_provider.eks_oidc_provider.url, "https://", "")}:sub"
            values = [
                "system:serviceaccount:kube-system:cluster-autoscaler"
            ]
        }

        principals {
            identifiers = [data.aws_iam_openid_connect_provider.eks_oidc_provider.arn]
            type = "Federated"
        }
    }
}

resource "aws_iam_role" "cluster_autoscaler" {
    count = var.enable_cluster_autoscaler ? 1 : 0

    assume_role_policy = data.aws_iam_policy_document.cluster_autoscaler.json
    name = "eks-${var.env}-cluster-autoscaler"
}


resource "aws_iam_policy" "cluster_autoscaler" {
    count = var.enable_cluster_autoscaler ? 1 : 0
    name = "${var.env}-cluster-autoscaler"
    policy = jsonencode({
        Version = "2012-10-17"
        Statement = [
            {
                Action = [
                    "autoscaling:DescribeAutoScalingGroups",
                    "autoscaling:DescribeAutoScalingInstances",
                    "autoscaling:DescribeLaunchConfigurations",
                    "autoscaling:DescribeScalingActivities",
                    "ec2:DescribeInstanceTypes",
                    "ec2:DescribeLaunchTemplatesVersions"
                ]
                Effect = "Allow"
                Resource = "*"
            },
            {
                Action = [
                    "autoscaling:SetDesiredCapacity",
                    "autoscaling:TerminateInstanceInAutoScalingGroup"
                ]
                Effect = "Allow"
                Resource = "*"
            }
        ]
    })
}

resource "aws_iam_role_policy_attachment" "cluster_autoscaler" {
    count = var.enable_cluster_autoscaler ? 1 : 0
    role = aws_iam_role.cluster_autoscaler[0].name
    policy_arn = aws_iam_policy.cluster_autoscaler[0].arn
}


resource "helm_release" "cluster_autoscaler" {
    count = var.enable_cluster_autoscaler ? 1 : 0
    name = "cluster-autoscaler"
    repository = "https://kubernetes.github.io/autoscaler"
    chart = "cluster-autoscaler"
    namespace = "kube-system"
    version = "9.20.0"

    set {
        name = "rbac.serviceAccount.name"
        value = "cluster-autoscaler"
    }

    set {
        name = "rbac.serviceAccount.annotations.eks\\.amazonaws\\.com/role-arn"
        value = aws_iam_role.cluster_autoscaler[0].arn
    }
    set {
        name = "autoDiscovery.clusterName"
        value = var.eks_cluster_name
    }
}



