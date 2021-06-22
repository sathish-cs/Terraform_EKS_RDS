output "eks_cluster" {
  value = aws_eks_cluster.eks-cluster.endpoint
}

output "eks_cluster_name" {
  value = aws_eks_cluster.eks-cluster.name
}