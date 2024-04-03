# Create the VPC
module "vpc" {
  source        = "../modules/vpc"
  REGION        = var.region
  PROJECT_NAME  = var.project_name
  VPC_CIDR      = var.vpc_cidr
  PUB_SUB1_CIDR = var.pub_sub1_cidr
  PUB_SUB2_CIDR = var.pub_sub2_cidr
  PRI_SUB3_CIDR = var.pri_sub3_cidr
  PRI_SUB4_CIDR = var.pri_sub4_cidr
}

module "net-gw" {
  source      = "../modules/nat-gw"
  IGW_ID      = module.vpc.IGW_ID
  VPC_ID      = module.vpc.VPC_ID
  PUB_SUB1_ID = module.vpc.PUB_SUB1_ID
  PUB_SUB2_ID = module.vpc.PUB_SUB2_ID
  PRI_SUB3_ID = module.vpc.PRI_SUB3_ID
  PRI_SUB4_ID = module.vpc.PRI_SUB4_ID
}

# create iam
module "iam" {
  source       = "../modules/iam"
  PROJECT_NAME = var.project_name
}

# create EKS Cluster
module "eks" {
  source               = "../modules/eks"
  PROJECT_NAME         = var.project_name
  EKS_CLUSTER_ROLE_ARN = module.iam.EKS_CLUSTER_ROLE_ARN
  PUB_SUB1_ID          = module.vpc.PUB_SUB1_ID
  PUB_SUB2_ID          = module.vpc.PUB_SUB2_ID
  PRI_SUB3_ID          = module.vpc.PRI_SUB3_ID
  PRI_SUB4_ID          = module.vpc.PRI_SUB4_ID
}

# create Node Group
module "NodeGroup" {
  source           = "../modules/nodeGroup"
  NODE_GROUP_ARN   = module.iam.NODE_GROUP_ROLE_ARN
  PRI_SUB3_ID      = module.vpc.PRI_SUB3_ID
  PRI_SUB4_ID      = module.vpc.PRI_SUB4_ID
  EKS_CLUSTER_NAME = module.eks.EKS_CLUSTER_NAME
}
