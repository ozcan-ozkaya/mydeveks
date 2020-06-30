resource "helm_release" "aws-alb-ingress-controller" {
  name       = "alb-ingress-controller"
  repository = "https://kubernetes-charts-incubator.storage.googleapis.com"
  chart      = "incubator/aws-alb-ingress-controller"
  version    = "1.0.0"
  namespace  = "kube-system"

#  values = [
#    "${file("alb-ingress-controller-chart-values.yaml")}"
#  ]

  set {
    name  = "autoDiscoverAwsRegion"
    value = "true"
  }

  set {
    name  = "autoDiscoverAwsVpcID"
    value = "true"
  }

  set {
    name  = "clusterName"
    value = var.cluster_name
  }
#  Uncomment this if the  alb ingress controller shouuld wtach only one specific namespace
#  set {
#    name  = "scope.ingressClass"
#    value = var.ALB_NAMESPACE
#  }

  set {
    name  = "rbac.create"
    value = "true"
  }

  set {
    name  = "rbac.serviceAccount.create"
    value = "true"
  }
}