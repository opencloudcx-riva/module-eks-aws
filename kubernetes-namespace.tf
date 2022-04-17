# Developed by RIVA Solutions Inc 2022.  Authorized Use Only

resource "kubernetes_namespace" "extra" {
  count = length(var.additional_namespaces)
  metadata {
    name = var.additional_namespaces[count.index]
  }

  depends_on = [
    module.eks,
  ]
}

# resource "kubernetes_namespace" "cert-manager" {
#   metadata {
#     name = "cert-manager"
#   }

#   depends_on = [
#     module.eks,
#   ]
# }

# resource "kubernetes_namespace" "ingress-nginx" {
#   metadata {
#     name = "ingress-nginx"
#   }

#   depends_on = [
#     module.eks,
#   ]
# }

