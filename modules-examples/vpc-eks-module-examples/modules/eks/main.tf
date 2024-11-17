resource "aws_iam_role" "eks-cluster-iam-role" {
    name= var.eks_iam_role_name

    assume_role_policy = <<POLICY
  {
    "Version" : "2012-10-17",
    "Statement" : [
        {
            "Effect" : "Allow",
            "Principal" : {
                "Service" : "eks.amazonaws.com"
            },
            "Action" : "sts:AssumeRole"
        }
    ]
  }
POLICY
}

# Attach the AmazonEKSClusterPolicy
resource "aws_iam_role_policy_attachment" "eks_cluster_policy" {
  role       = aws_iam_role.eks-cluster-iam-role.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSClusterPolicy"
}

# Attach the AmazonEKSVPCResourceControllerPolicy
resource "aws_iam_role_policy_attachment" "eks_vpc_resource_controller_policy" {
  role       = aws_iam_role.eks-cluster-iam-role.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSVPCResourceController"
}


# Create KMS Key for EKS Encryption
resource "aws_kms_key" "eks_key" {
  description = "KMS key for EKS cluster encryption"
}

resource "aws_kms_alias" "eks_alias" {
  name          = "alias/${var.eks_cluster_name}-eks-key"
  target_key_id = aws_kms_key.eks_key.id
}



resource "aws_eks_cluster" "eks-cluster" {
    name = var.eks_cluster_name
    role_arn = aws_iam_role.eks-cluster-iam-role.arn
    version = var.k8s_version

    vpc_config {
      endpoint_private_access = false
      endpoint_public_access = true

      subnet_ids = var.subnet_ids
    }

    encryption_config {
        resources = ["secrets"]
        provider {
            key_arn = aws_kms_key.eks_key.arn
        }
    }

    tags = merge(
        var.tags,
        {"Name" = "test-eks-cluster"}
    )

    depends_on = [ aws_iam_role_policy_attachment.eks_cluster_policy ]
  
}