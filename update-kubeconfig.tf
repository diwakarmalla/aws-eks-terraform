resource "local-exec" "update_kubeconfig" {
    command = "aws eks --region ${var.region} update-kubeconfig --name ${var.cluster_name}"
    interpreter = ["bash", "-c"]
    depends_on = [ module.eks.eks_managed_node_groups ]
}