# Developed by RIVA Solutions Inc 2022.  Authorized Use Only

variable "name" {
  type = string
}

variable "stack" {
  type    = string
  default = "dev"
}

variable "cluster_version" {
  type = string
}

variable "region" {
  type = string
}

variable "dns_zone" {
  type    = string
  default = "opencloudcx.internal"
}

variable "additional_namespaces" {
  description = "Additional namespaces to create in cluster"
  type        = list(string)
  default     = []
}

variable "helm_timeout" {
  description = "Timeout value to wait for helm chart deployment"
  type        = number
  default     = 600
}

### tags
variable "tags" {
  description = "The key-value maps for tagging"
  type        = map(string)
  default     = {}
}

variable "map_roles" {
  description = "Additional IAM roles to add to the aws-auth configmap."
  type = list(object({
    rolearn  = string
    username = string
    groups   = list(string)
  }))
  default = []
}

variable "map_users" {
  description = "Additional IAM users to add to the aws-auth configmap."
  type = list(object({
    userarn  = string
    username = string
    groups   = list(string)
  }))
  default = []
}

variable "worker_groups" {
  type = list(object({
    name                 = string
    instance_type        = string
    asg_desired_capacity = number
  }))
}

variable "cluster_delete_timeout" {
  description = "Timeout value when deleting the EKS cluster."
  type        = string
  default     = "15m"
}

variable "write_kubeconfig" {
  description = "Whether to write a Kubectl config file containing the cluster configuration. Saved to `kubeconfig_output_path`."
  type        = bool
  default     = true
}

variable "private_subnets" {
  type    = list(string)
  default = ["10.0.1.0/24", "10.0.2.0/24", "10.0.3.0/24"]
}

variable "public_subnets" {
  type    = list(string)
  default = ["10.0.4.0/24", "10.0.5.0/24", "10.0.6.0/24"]
}

variable "cidr" {
  type    = string
  default = "10.0.0.0/16"
}

# variable "aws_certificate_arn" {
#   description = "AWS SSL certificate ARN"
#   type        = string
# }

###########################################################
### nginx ingress helm information
###

variable "ingress_helm_repo" {
  description = "URL for Ingress Controller helm chart"
  type        = string
  default     = "https://kubernetes.github.io/ingress-nginx"
}

###
###########################################################

###########################################################
### cert_manager helm information
###

variable "cert_manager_helm_repo" {
  description = "URL for cert-manager helm chart repository"
  type        = string
  default     = "https://charts.jetstack.io"
}

###
###########################################################

