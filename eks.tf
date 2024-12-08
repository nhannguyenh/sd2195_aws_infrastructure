resource "aws_iam_role" "sd2195_eks_cluster_role" {
  name = "sd2195_eks_cluster_role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect = "Allow"
        Action = "sts:AssumeRole"
        Principal = {
          Service = "eks.amazonaws.com"
        }
      }
    ]
  })
}

resource "aws_iam_role_policy_attachment" "sd2195_eks_policy_attachment" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSClusterPolicy"
  role       = aws_iam_role.sd2195_eks_cluster_role.name
}

resource "aws_eks_cluster" "sd2195_eks" {
  name     = "sd2195_eks_cluster"
  version  = var.eks_version
  role_arn = aws_iam_role.sd2195_eks_cluster_role.arn

  vpc_config {
    endpoint_private_access = false
    endpoint_public_access  = true

    subnet_ids = [
      aws_subnet.sd2195_private_subnet_zone1.id,
      aws_subnet.sd2195_private_subnet_zone2.id
    ]
  }

  access_config {
    authentication_mode                         = "API"
    bootstrap_cluster_creator_admin_permissions = true
  }

  depends_on = [aws_iam_role_policy_attachment.sd2195_eks_policy_attachment]
}
