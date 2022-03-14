# Developed by RIVA Solutions Inc 2022.  Authorized Use Only

resource "helm_release" "cert-manager" {
  name             = "cert-manager"
  chart            = "cert-manager"
  namespace        = "cert-manager"
  repository       = var.cert_manager_helm_repo
  timeout          = var.helm_timeout
  create_namespace = false
  reset_values     = false

  set {
    name  = "installCRDs"
    value = "true"
  }

  depends_on = [
    module.eks,
    kubernetes_namespace.cert-manager,
  ]
}

resource "helm_release" "ingress-controller" {
  name             = "ingress-nginx"
  chart            = "ingress-nginx"
  namespace        = "ingress-nginx"
  repository       = var.ingress_helm_repo
  timeout          = var.helm_timeout
  create_namespace = false
  reset_values     = false

  set {
    name  = "controller.ingressClassResource.name"
    value = "insecure"
  }

  depends_on = [
    module.eks,
    kubernetes_namespace.ingress-nginx
  ]
}

# resource "helm_release" "k8s_dashboard" {
#   name             = "k8s-dashboard"
#   chart            = "kubernetes-dashboard"
#   namespace        = "spinnaker"
#   repository       = var.k8s_dashboard_helm_repo
#   timeout          = var.helm_timeout
#   version          = var.k8s_dashboard_helm_chart_version
#   create_namespace = false
#   reset_values     = false

#   set {
#     name  = "settings.itemsPerPage"
#     value = 30
#   }

#   set {
#     name  = "ingress.enabled"
#     value = true
#   }

#   set {
#     name  = "service.type"
#     value = "LoadBalancer"
#   }

#   set {
#     name  = "settings.clusterName"
#     value = "OpenCloudCX"
#     #value = "OpenCloudCX [stack:${var.stack}]"
#   }

#   depends_on = [
#     module.eks,
#     kubernetes_namespace.spinnaker,
#   ]
# }

# resource "helm_release" "prometheus" {
#   name             = "prometheus"
#   chart            = "prometheus"
#   namespace        = "opencloudcx"
#   repository       = var.prometheus_helm_repo
#   timeout          = var.helm_timeout
#   version          = var.prometheus_helm_chart_version
#   create_namespace = false
#   reset_values     = false

#   set {
#     name  = "alertmanager.persistentVolume.storageClass"
#     value = "gp2"
#   }

#   set {
#     name  = "server.persistentVolume.storageClass"
#     value = "gp2"
#   }

#   depends_on = [
#     module.eks,
#     kubernetes_namespace.opencloudcx,
#   ]

# }