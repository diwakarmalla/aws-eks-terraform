# resource "aws_iam_user" "user" {
#     for_each = local.users
#     name = each.key
# }

# resource "aws_iam_access_key" "access_key" {
#     for_each = local.users
#     user = aws_iam_user.user[each.key].name
# }

# resource "aws_iam_group" "groups" {
#     for_each = local.users
#     name = "${each.key}_group"
# }

# resource "aws_iam_group_membership" "group_membership" {
#     for_each = local.users
#     name = "${each.key} group membership"
#     users = [ aws_iam_user.user[each.key].name ]
#     group = aws_iam_group.groups[each.key].name
# }
data "aws_iam_user" "cloud_user" {
  user_name = "cloud_user"
}

module "vpc_cni_irsa" {
  source  = "terraform-aws-modules/iam/aws//modules/iam-role-for-service-accounts-eks"
  version = "~> 5.0"

  role_name_prefix      = "VPC-CNI-IRSA"
  attach_vpc_cni_policy = true
  vpc_cni_enable_ipv4   = true

  oidc_providers = {
    main = {
      provider_arn               = module.eks.oidc_provider_arn
      namespace_service_accounts = ["kube-system:aws-node"]
    }
  }
}

#Role for EBS CSI driver
resource "aws_iam_role" "ebs_csi_driver" {
  name               = "${var.cluster_name}-ebs-csi-driver"
  assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Principal": {
        "Federated": "${module.eks.oidc_provider_arn}"
      },
      "Action": "sts:AssumeRoleWithWebIdentity",
      "Condition": {
        "StringEquals": {
          "${module.eks.oidc_provider}:sub": "system:serviceaccount:kube-system:ebs-csi-controller-sa"
        }
      }
    }
  ]
}
EOF
}
resource "aws_iam_role_policy_attachment" "ebs_csi_driver" {
  role       = aws_iam_role.ebs_csi_driver.name
  policy_arn = "arn:aws:iam::aws:policy/service-role/AmazonEBSCSIDriverPolicy"
}