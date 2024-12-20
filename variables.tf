variable "aws_region" {
  type        = string
  description = "The region where AWS operations"
}

variable "vpc_cidr_block" {
  type        = string
  description = "Define VPC CIDR block"
}

variable "subnet_cidr_blocks" {
  type        = list(string)
  description = "Define subnet CIDR block"
}

variable "availability_zones" {
  type        = list(string)
  description = "Define AZs in the specific region"
}

variable "allow_anywhere_cidr_block" {
  type        = string
  description = "The CIDR block of the route"
}

variable "jenkins_port" {
  type        = number
  description = "Jenkisn HTTP port"
}

variable "ssh_port" {
  type        = number
  description = "SSH port"
}

variable "ami" {
  type        = string
  description = "Define AMI id"
}

variable "instance_type" {
  type        = string
  description = "EC2 instance type"
}

variable "node_instance_type" {
  type        = string
  description = "Node instance type"
}

variable "eks_name" {
  type        = string
  description = "Name of EKS cluster"
}

variable "eks_version" {
  type        = string
  description = "The version of EKS cluster"
}