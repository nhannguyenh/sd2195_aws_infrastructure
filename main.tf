terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
}

# # Create ERC
# resource "aws_ecr_repository" "sd2195_ecr" {
#   name                 = "sd2195_ecr"
#   image_tag_mutability = "MUTABLE"

#   image_scanning_configuration {
#     scan_on_push = true
#   }
# }

# # Create EKS
# module "eks" {
#   source  = "terraform-aws-modules/eks/aws"
#   version = "~> 20.0"

#   cluster_name                   = "sd2195_cluster"
#   cluster_version                = "1.31"
#   cluster_endpoint_public_access = true

#   # EKS Addons
#   cluster_addons = {
#     coredns = {
#       most_recent = true
#     }
#     kube-proxy = {
#       most_recent = true
#     }
#     vpc-cni = {
#       most_recent = true
#     }
#   }

#   vpc_id = aws_vpc.sd2195_vpc.id
#   subnet_ids = [
#     aws_subnet.sd2195_public_subnet_1.id,
#     aws_subnet.sd2195_public_subnet_2.id
#   ]

#   eks_managed_node_group_defaults = {
#     # Starting on 1.30, AL2023 is the default AMI type for EKS managed node groups
#     # ami_type                              = "AL2023"
#     instance_types                        = ["t2.micro"]
#     attach_cluster_primary_security_group = true
#   }
#   eks_managed_node_groups = {
#     amc-cluster-wg = {
#       min_size     = 1
#       max_size     = 2
#       desired_size = 1

#       instance_types = ["t3.micro"]
#       capacity_type  = "SPOT"

#       tags = {
#         ExtraTag = "sd2195_eks_node_group"
#       }
#     }
#   }

#   tags = {
#     Name = "sd2195_cluster"
#   }
# }