##############################
# EKS Cluster
##############################
resource "aws_eks_cluster" "this" {
  name     = var.cluster_name
  role_arn = var.cluster_role_arn
  version  = var.kubernetes_version

  vpc_config {
    subnet_ids              = var.private_subnet_ids
    endpoint_private_access = true
    endpoint_public_access  = true
  }

  tags = {
    Name = var.cluster_name
    Environment = var.env_name
  }
}

##############################
# EKS Node Group
##############################
resource "aws_eks_node_group" "this" {
  cluster_name    = aws_eks_cluster.this.name
  node_group_name = "${var.cluster_name}-node-group"
  node_role_arn   = var.node_role_arn
  subnet_ids      = var.private_subnet_ids
  ami_type        = "AL2_x86_64" # matches Kubernetes 1.29

  scaling_config {
    desired_size = var.node_desired_capacity
    min_size     = var.node_min_size
    max_size     = var.node_max_size
  }

  instance_types = var.node_instance_types

  # Removed SSH block to avoid KeyPair errors

  tags = {
    Name        = "${var.cluster_name}-node-group"
    Environment = var.env_name
  }

  depends_on = [aws_eks_cluster.this]
}

##############################
# Optional: Outputs for kubeconfig
##############################
data "aws_eks_cluster_auth" "this" {
  name = aws_eks_cluster.this.name
}
