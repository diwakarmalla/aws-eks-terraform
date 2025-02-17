terraform {
  backend "s3" {
  }
  required_providers {
    helm = {
      source  = "hashicorp/helm"
      version = ">= 2.0.0"
    }

    kubernetes = {
        version = ">= 2.0.0"
        source = "hashicorp/kubernetes"
    }

    kubectl = {
      source = "gavinbunney/kubectl"
      version = "1.14.0"
    }
  }
}

provider "aws" {
  region = "us-east-1"
}

provider "helm" {
  kubernetes {
    config_path = "~/.kube/config"
  }
  
}

provider "kubernetes" {
  config_path = "~/.kube/config"
}

# data "aws_eks_cluster" "ClusterName" {
#   name = "dev-cluster"
# }
# data "aws_eks_cluster_auth" "ClusterName_auth" {
#   name = "dev-cluster_auth"
# }


data "aws_availability_zones" "available" {
  state = "available"
}

data "aws_caller_identity" "current" {}

provider "kubectl" {
  load_config_file = false
  host                   = data.aws_eks_cluster.ClusterName.endpoint
  cluster_ca_certificate = base64decode(module.eks.cluster_name.certificate_authority[0].data)
  token                  = module.eks.cluster_name_auth.token
  config_path = "~/.kube/config"
}