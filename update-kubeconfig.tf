resource "null_resource" "kubectl" {
    depends_on = [ module.eks.eks_managed_node_groups ]
    provisioner "local-exec" {
        command = "aws eks --region ${var.region} update-kubeconfig --name ${var.cluster_name}"
    }
}