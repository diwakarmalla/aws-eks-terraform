
output "aws_eks_cluster_name" {
  value       = module.eks.cluster_name
}

output "aws_eks_cluster_version" {
  value       = module.eks.cluster_version
}

output "aws_eks_cluster_endpoint" {
  value       = module.eks.cluster_endpoint
}

output "aws_eks_access_entries" {
  value = module.eks.access_entries
}

output "aws_eks_oidc_provider" {
  value = module.eks.oidc_provider
}

output "aws_eks_oidc_provider_arn" {
  value = module.eks.oidc_provider_arn

}