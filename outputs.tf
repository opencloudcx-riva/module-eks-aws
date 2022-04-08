# Developed by RIVA Solutions Inc 2022.  Authorized Use Only

output "aws_eks_cluster_endpoint" {
  value = data.aws_eks_cluster.cluster.endpoint
}

output "aws_eks_cluster_auth_token" {
  value = data.aws_eks_cluster_auth.cluster.token
}

output "aws_eks_cluster_ca_certificate" {
  value = base64decode(data.aws_eks_cluster.cluster.certificate_authority[0].data)
}

output "aws_eks_cluster" {
  value = data.aws_eks_cluster.cluster
}

output "vpc_id" {
  value = (var.create_vpc ? module.vpc[0].vpc_id : var.vpc_id)
}