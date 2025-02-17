locals {
  account_id          = data.aws_caller_identity.current.account_id
  vpc_id              = module.vpc.vpc_id
  vpc_cidr            = module.vpc.vpc_cidr_block
  public_subnets_ids  = module.vpc.public_subnets
  private_subnets_ids = module.vpc.private_subnets
  subnets_ids         = concat(local.public_subnets_ids, local.private_subnets_ids)
  cluster_enabled_log_types = ["controllerManager", "scheduler","authenticator", "audit", "api"]
  eks_access_policy = {
    viewer = "arn:aws:eks::aws:cluster-access-policy/AmazonEKSViewPolicy",
    admin  = "arn:aws:eks::aws:cluster-access-policy/AmazonEKSClusterAdminPolicy"
  }
  eks_access_entries = flatten([for k, v in var.access_entries : [for s in v.user_arn : { username = s, access_policy = lookup(local.eks_access_policy, k), group = k }]])
  users = {
    developer = "developer",
    admin     = "admin",
  }
}