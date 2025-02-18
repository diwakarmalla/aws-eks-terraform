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
    depends_on = [ null_resource.kubectl ]
    metadata {
      name = "monitoring"
    }
  
}

resource "helm_release" "prometheus" {
    depends_on = [ kubernetes_namespace.kube-ns ]
    name = "prometheus"
    repository = "https://prometheus-community.github.io/helm-charts"
    chart = "kube-prometheus-stack"
    namespace = kubernetes_namespace.kube-ns.id
    create_namespace = true
    version = "45.7.1"
    values = [ 
        file("prometheus/values.yaml")
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
            cpu    = "200m"
            memory = "50Mi"
        }
        requests = {
            cpu    = "100m"
            memory = "30Mi"
        }
        })
    }
  
}