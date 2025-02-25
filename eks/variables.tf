variable "cluster_name" {
    description = "EKS Cluster Name"
    type = string
}

variable "cluster_version" {
    description = "EKS cluster version"
    type = string
}

variable "node-group" {
    type = any
    description = "Nodegroup config"
}

variable "region" {
    description = "AWS Region"
    type = string
}

variable "ami" {
    description = "AMI"
    type = string
}

variable "instance_type" {
    description = "EC2 Instance types" 
    type = list(string)
}

variable "vpc_name" {
    description = "VPC name"
    type = string
  
}

variable "vpc_cidr" {
    description = "VPC CIDR"
    type = string
  
}

variable "private_subnet_cidr" {
    description = "Private Subnet CIDR"
    type = list(string)
  
}

variable "public_subnet_cidr" {
    description = "Public Subnet CIDR"
    type = list(string)
}