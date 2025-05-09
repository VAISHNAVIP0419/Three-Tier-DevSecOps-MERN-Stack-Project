output "eks_cluster_name" {
  value = aws_eks_cluster.eks.name
}

output "eks_node_group_name" {
  value = aws_eks_node_group.node_group.node_group_name
}

output "eks_cluster_security_group_id" {
  value = aws_eks_cluster.eks.vpc_config[0].cluster_security_group_id
}
