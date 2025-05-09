provider "aws" {
  region = "ap-south-1"
}

# VPC and Subnet IDs (you can use your existing ones)
variable "vpc_id" {
  default = "vpc-0a57822b15100e18f"
}

variable "subnet_ids" {
  default = [
    "subnet-0520c3fa6c0451794",
    "subnet-03f973d59ed405bbd",
    "subnet-055d25c03ce19fe0b"
  ]
}

# EKS Cluster Resource
resource "aws_eks_cluster" "eks" {
  name     = "vaishnavi-eks"
  role_arn = aws_iam_role.eks_cluster_role.arn

  vpc_config {
    subnet_ids             = var.subnet_ids
    endpoint_public_access = true
    endpoint_private_access = false
  }

  depends_on = [aws_iam_role_policy_attachment.eks_cluster_AmazonEKSClusterPolicy]
}

# EKS Node Group Resource
resource "aws_eks_node_group" "node_group" {
  cluster_name    = aws_eks_cluster.eks.name
  node_group_name = "vaishnavi-node-group"
  node_role_arn   = aws_iam_role.eks_node_role.arn
  subnet_ids      = var.subnet_ids

  scaling_config {
    desired_size = 2
    max_size     = 3
    min_size     = 1
  }

  instance_types = ["t3.medium"]

  depends_on = [aws_eks_cluster.eks]
}

# Security Group Rule to Allow Jenkins to Access EKS
resource "aws_security_group_rule" "allow_jenkins_to_eks" {
  type                     = "ingress"
  from_port                = 443
  to_port                  = 443
  protocol                 = "tcp"
  security_group_id        = aws_eks_cluster.eks.vpc_config[0].cluster_security_group_id
  source_security_group_id = "YOUR_JENKINS_EC2_SECURITY_GROUP_ID"  # Replace this with your Jenkins EC2 SG ID
}
