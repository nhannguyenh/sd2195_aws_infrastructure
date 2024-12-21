aws_region         = "ap-southeast-1"
availability_zones = ["ap-southeast-1a", "ap-southeast-1b"]

allow_anywhere_cidr_block = "0.0.0.0/0"
vpc_cidr_block            = "10.0.0.0/16"
subnet_cidr_blocks        = ["10.0.1.0/24", "10.0.2.0/24", "10.0.3.0/24", "10.0.4.0/24"]

jenkins_port = 8080
ssh_port     = 22

ami                = "ami-0f935a2ecd3a7bd5c" // Amazon Linux 2023 AMI 2023.6.20241121.0 x86_64 HVM kernel-6.1
instance_type      = "t2.micro"
node_instance_type = "t2.medium"

eks_name    = "sd2195_eks_cluster"
eks_version = "1.31"