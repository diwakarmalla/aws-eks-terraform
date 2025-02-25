# data "aws_eks_node_group" "eks_node_group" {
#     cluster_name = "dev-cluster"
#     node_group_name = "eks-monitoring"
# }

# resource "time_sleep" "wait_for_kubernetes" {
#     depends_on = [ 
#         module.eks.eks_managed_node_groups
#      ]

#      create_duration = "20s"
  
# }

resource "kubernetes_namespace" "kube-ns" {
    # depends_on = [ module.eks.eks_managed_node_groups ]
    metadata {
      name = var.prometheus_ns
    }
  
}

resource "helm_release" "prometheus" {
    depends_on = [ kubernetes_namespace.kube-ns ]
    name = "prometheus"
    repository = "https://prometheus-community.github.io/helm-charts"
    chart = "kube-prometheus-stack"
    namespace = kubernetes_namespace.kube-ns.id
    create_namespace = true
    version = var.prometheus_version
    values = [ 
        file("files/values.yaml")
    ]
    timeout = 2000

    set {
        name = "podSecurityPolicy.enabled"
        value = true
    }

    set {
      name = "server.persistentVolume.enabled"
      value = true
    }

    set {
      name = "server\\.resources"
      value = yamlencode({
        limits = {
            cpu    = "1200m"
            memory = "500Mi"
        }
        requests = {
            cpu    = "1000m"
            memory = "300Mi"
        }
        })
    }
  
}