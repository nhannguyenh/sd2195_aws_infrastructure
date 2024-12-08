resource "aws_iam_role" "sd2195_eks_nodes" {
  name = "sd2195_eks_nodes"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect = "Allow"
        Action = "sts:AssumeRole"
        Principal = {
          Service = "ec2.amazonaws.com"
        }
      }
    ]
  })
}

resource "aws_iam_role_policy_attachment" "sd2195_eks_worker_node_policy" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSWorkerNodePolicy"
  role       = aws_iam_role.sd2195_eks_nodes.name
}

resource "aws_iam_role_policy_attachment" "sd2195_eks_cni_policy" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKS_CNI_Policy"
  role       = aws_iam_role.sd2195_eks_nodes.name
}

resource "aws_iam_role_policy_attachment" "sd2195_ec2_container_registry_read_only" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEC2ContainerRegistryReadOnly"
  role       = aws_iam_role.sd2195_eks_nodes.name
}

resource "aws_eks_node_group" "sd2195_eks_node_group" {
  cluster_name    = aws_eks_cluster.sd2195_eks.name
  version         = var.eks_version
  node_group_name = "sd2195_node_group"
  node_role_arn   = aws_iam_role.sd2195_eks_nodes.arn

  subnet_ids = [
    aws_subnet.sd2195_private_subnet_zone1.id,
    aws_subnet.sd2195_private_subnet_zone2.id
  ]

  capacity_type  = "ON_DEMAND"
  instance_types = [var.instance_type]

  scaling_config {
    desired_size = 1
    max_size     = 10
    min_size     = 0
  }

  update_config {
    max_unavailable = 1
  }

  labels = {
    role = "sd2195_node_group"
  }

  depends_on = [
    aws_iam_role_policy_attachment.sd2195_eks_worker_node_policy,
    aws_iam_role_policy_attachment.sd2195_eks_cni_policy,
    aws_iam_role_policy_attachment.sd2195_ec2_container_registry_read_only,
  ]

  # Allow external changes without Terraform plan difference
  lifecycle {
    ignore_changes = [scaling_config[0].desired_size]
  }
}