## Documentation for eks module is at https://github.com/terraform-aws-modules/terraform-aws-eks

module "eks" {
  source  = "terraform-aws-modules/eks/aws"
  version = "17.23.0"

  cluster_name    = local.name
  cluster_version = local.cluster_version

  vpc_id  = (var.create_vpc ? module.vpc[0].vpc_id : var.vpc_id)
  subnets = (var.create_vpc ? module.vpc[0].private_subnets : var.private_subnets)

  cluster_endpoint_private_access = true
  cluster_endpoint_public_access  = true

  cluster_encryption_config = [
    {
      provider_key_arn = aws_kms_key.eks.arn
      resources        = ["secrets"]
    }
  ]

  worker_groups    = var.worker_groups
  map_roles        = var.map_roles
  map_users        = var.map_users
  write_kubeconfig = var.write_kubeconfig

  tags = {
    Example    = local.name
    GithubRepo = "terraform-aws-eks"
    GithubOrg  = "terraform-aws-modules"
    stack      = var.stack
  }
}

