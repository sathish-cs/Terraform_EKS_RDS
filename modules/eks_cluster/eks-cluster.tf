
# EKS Cluster Resources

resource "aws_eks_cluster" "eks-cluster" {
  name     = var.eks-cluster-name
  role_arn = aws_iam_role.eks.arn

  vpc_config {
    security_group_ids = [aws_security_group.eks.id]
    subnet_ids         = var.public_subnet
  }

  depends_on = [
    aws_iam_role_policy_attachment.eks-AmazonEKSClusterPolicy,
    aws_iam_role_policy_attachment.eks-AmazonEKSServicePolicy,
  ]
}


resource "aws_security_group" "eks" {
  name        = var.security_group_name
  description = "Cluster communication with worker nodes"
  vpc_id      = var.vpc

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = var.security_group_name
  }
}

resource "aws_security_group_rule" "eks-ingress" {
  source_security_group_id       = aws_security_group.eks.id
  description       = "Allow workstation to communicate with the cluster API Server"
  from_port         = 443
  protocol          = "tcp"
  security_group_id = aws_security_group.eks.id
  to_port           = 443
  type              = "ingress"
}

# EKS Worker nodes

resource "aws_eks_node_group" "eks-workers" {
  cluster_name    = aws_eks_cluster.eks-cluster.id
  node_group_name = var.node_group_name
  node_role_arn   = aws_iam_role.eks-workers.arn
  subnet_ids      = var.private_subnet
  remote_access {
    ec2_ssh_key = var.key
    source_security_group_ids = [var.security_group]
  }
  scaling_config {
    desired_size = 1
    max_size     = 3
    min_size     = 1
  }
  tags = {
    Name = "EKS-Cluster"
  }

  depends_on = [
    aws_iam_role_policy_attachment.eks-workers-AmazonEKSWorkerNodePolicy,
    aws_iam_role_policy_attachment.eks-workers-AmazonEKS_CNI_Policy,
    aws_iam_role_policy_attachment.eks-workers-AmazonEC2ContainerRegistryReadOnly,
  ]
}