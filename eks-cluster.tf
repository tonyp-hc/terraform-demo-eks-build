module "eks" {
  source       = "app.terraform.io/TonyPulickal/eks/aws"
  cluster_name = local.cluster_name
  subnets      = module.vpc.private_subnets

  tags = {
    Environment = var.env
    GithubRepo  = "tonyp-hc/terraform-aws-eks"
    GithubOrg   = "tonyp-hc"
    Owner       = var.owner
    TTL         = var.ttl
  }

  vpc_id = module.vpc.vpc_id

  worker_groups = [
    {
      name                          = "worker-group-1"
      instance_type                 = "t2.small"
      additional_userdata           = "echo foo bar"
      asg_desired_capacity          = 2
      additional_security_group_ids = [module.worker_group_mgmt_one.this_security_group_id]
    },
    {
      name                          = "worker-group-2"
      instance_type                 = "t2.medium"
      additional_userdata           = "echo foo bar"
      additional_security_group_ids = [module.worker_group_mgmt_two.this_security_group_id]
      asg_desired_capacity          = 1
    },
  ]
}

data "aws_eks_cluster" "cluster" {
  name = module.eks.cluster_id
}

data "aws_eks_cluster_auth" "cluster" {
  name = module.eks.cluster_id
}

provider "kubernetes" {	
  host                    = data.aws_eks_cluster.cluster.endpoint
  cluster_ca_certificate  = base64decode(data.aws_eks_cluster.cluster.certificate_authority.0.data)
  token                   = data.aws_eks_cluster_auth.cluster.token
  load_config_file        = "false"
  version                 = "~> 1.9"
}
