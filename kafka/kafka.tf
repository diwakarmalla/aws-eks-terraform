# Create a namespace for observability

resource "kubernetes_namespace" "kafka-namespace" {
    # depends_on = [ module.eks.eks_managed_node_groups ]
    metadata {
        name = var.kafka_ns
    }
}


# Helm chart for Strimzi Kafka
resource "helm_release" "strimzi-cluster-operator" {
  name = "strimzi-cluster-operator"  
  repository = "https://strimzi.io/charts/"
  chart = "strimzi-kafka-operator"
  version = var.kafka_version
  namespace = kubernetes_namespace.kafka-namespace.metadata[0].name
  depends_on = [kubernetes_namespace.kafka-namespace]
}