## Documentation for eks module is at https://github.com/terraform-aws-modules/terraform-aws-eks

module "eks" {
  source  = "terraform-aws-modules/eks/aws"
  version = "18.20.2"

  cluster_name    = local.name
  cluster_version = local.cluster_version

  vpc_id     = var.vpc_id
  subnet_ids = var.private_subnets

  cluster_endpoint_private_access = true
  cluster_endpoint_public_access  = true
  enable_irsa                     = false

  cluster_encryption_config = [
    {
      provider_key_arn = aws_kms_key.eks.arn
      resources        = ["secrets"]
    }
  ]

  eks_managed_node_group_defaults = {
    ami_type                   = "AL2_x86_64"
    disk_size                  = 50
    instance_types             = ["m5.large"]
    iam_role_attach_cni_policy = true
  }

  eks_managed_node_groups = {
    bottlerocket_default = {
      create_launch_template = false
      launch_template_name   = ""

      # asg_desired_capacity = 3
      # min_size     = 3
      # max_size     = 5
      # desired_size = 3

      ami_type = "BOTTLEROCKET_x86_64"
      platform = "bottlerocket"
    }
  }

  # worker_groups    = var.worker_groups
  aws_auth_roles = var.map_roles
  aws_auth_users = var.map_users
  # write_kubeconfig = var.write_kubeconfig

  tags = {
    Example    = local.name
    GithubRepo = "terraform-aws-eks"
    GithubOrg  = "terraform-aws-modules"
    stack      = var.stack
  }
}

