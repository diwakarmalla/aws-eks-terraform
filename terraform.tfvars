region = "us-east-1"
cluster_name = "dev-cluster"
cluster_version = "1.32"
ami = "AL2_x86_64"
instance_type = ["t3.medium"]
node-group = {
      min_size     = 2
      max_size     = 6
      desired_size = 2
      disk_size      = 30
      iam_role_additional_policies = {
          ssm_access        = "arn:aws:iam::aws:policy/AmazonSSMManagedInstanceCore"
          cloudwatch_access = "arn:aws:iam::aws:policy/CloudWatchAgentServerPolicy"
          service_role_ssm  = "arn:aws:iam::aws:policy/service-role/AmazonEC2RoleforSSM"
          default_policy    = "arn:aws:iam::aws:policy/AmazonSSMManagedEC2InstanceDefaultPolicy"
          AmazonEBSCSIDriverPolicy = "arn:aws:iam::aws:policy/service-role/AmazonEBSCSIDriverPolicy"
       }
    }
vpc_name = "eks-monitoring"
vpc_cidr = "10.0.0.0/16"
private_subnet_cidr = ["10.0.0.0/22", "10.0.4.0/22", "10.0.8.0/22"]
public_subnet_cidr = ["10.0.100.0/22", "10.0.104.0/22", "10.0.108.0/22"]

access_entries =   {
      viewer = {
        user_arn = []
      }
      admin = {
        user_arn = ["arn:aws:iam::471112643429:user/cloud_user"]
      }
    }
