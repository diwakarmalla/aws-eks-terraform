resource "kubernetes_namespace" "keda-namespace" {
    # depends_on = [ module.eks.eks_managed_node_groups ]
    metadata {
        name = var.keda_ns
    }
}

resource "helm_release" "keda" {
  name = "keda"

  repository       = "https://kedacore.github.io/charts"
  chart            = "keda"
  namespace        = kubernetes_namespace.keda-namespace.metadata[0].name
  version          = var.keda_version
  # create_namespace = true
}