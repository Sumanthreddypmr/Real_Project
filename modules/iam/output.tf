output "eks_cluster_role_arn" {
  value       = aws_iam_role.eks_cluster_role.arn
  description = "ARN of EKS Cluster IAM Role"
}

output "eks_node_role_arn" {
  value       = aws_iam_role.eks_node_role.arn
  description = "ARN of EKS Worker Node IAM Role"
}

output "service_account_role_arn" {
  value       = var.create_irsa ? aws_iam_role.service_account_role[0].arn : ""
  description = "ARN of Service Account IAM Role (IRSA)"
}
