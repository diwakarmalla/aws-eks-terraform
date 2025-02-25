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

provider "helm" {
  kubernetes {
    config_path = "~/.kube/config"
  }
  
}

provider "kubernetes" {
  config_path = "~/.kube/config"
}

provider "kubectl" {
  load_config_file = false
  host                   = data.aws_eks_cluster.ClusterName.endpoint
  cluster_ca_certificate = base64decode(module.eks.cluster_name.certificate_authority[0].data)
  token                  = module.eks.cluster_name_auth.token
  config_path = "~/.kube/config"
}