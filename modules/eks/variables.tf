variable "cluster_name" {
  description = "EKS Cluster Name"
  type        = string
}

variable "cluster_role_arn" {
  description = "IAM Role ARN for the EKS cluster"
  type        = string
}

variable "node_role_arn" {
  description = "IAM Role ARN for the EKS node group"
  type        = string
}

variable "private_subnet_ids" {
  description = "Private subnet IDs for EKS cluster"
  type        = list(string)
}

variable "kubernetes_version" {
  description = "Kubernetes version for EKS cluster"
  type        = string
}

variable "node_instance_types" {
  description = "EC2 instance types for the node group"
  type        = list(string)
}

variable "node_desired_capacity" {
  description = "Desired node count"
  type        = number
}

variable "node_min_size" {
  description = "Minimum node count"
  type        = number
}

variable "node_max_size" {
  description = "Maximum node count"
  type        = number
}

variable "env_name" {
  description = "Environment name"
  type        = string
  default     = "dev"
}
