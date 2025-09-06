##############################
# Backend configuration
##############################
terraform {
  backend "s3" {
    bucket         = "sumanth-eks-tf-state-20250906"
    key            = "dev/terraform.tfstate"
    region         = "us-east-1"
    dynamodb_table = "eks-project-tf-lock"
  }
}

provider "aws" {
  region = "us-east-1"
}

##############################
# VPC Module
##############################
module "vpc" {
  source         = "../../modules/vpc"
  project        = var.project
  vpc_cidr       = var.vpc_cidr
  azs            = var.azs
  public_subnets = var.public_subnets
  private_subnets= var.private_subnets
}

##############################
# IAM Module
##############################
module "iam" {
  source       = "../../modules/iam"
  cluster_name = var.cluster_name
  create_irsa  = var.create_irsa
}

##############################
# EKS Module
##############################
module "eks" {
  source             = "../../modules/eks"
  cluster_name       = "sumanth_cluster"
  cluster_role_arn   = module.iam.eks_cluster_role_arn
  node_role_arn      = module.iam.eks_node_role_arn
  private_subnet_ids = module.vpc.private_subnets
  kubernetes_version = "1.29"
  node_instance_types   = ["t3.medium"]
  node_desired_capacity = 2
  node_min_size         = 1
  node_max_size         = 3
}
