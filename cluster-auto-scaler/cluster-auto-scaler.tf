resource "helm_release" "cluster-autoscaler" {
  name       = "cluster-autoscaler" 
  chart      = "stable/cluster-autoscaler"
  version    = "7.3.2"
  namespace  = "kube-system"

#  values = [
#    "${file("cluster-auto-scaler-chart-values.yaml")}"
#  ]

  set = {
    name = "rbac.create"
    value = "true"
    name = "rbac.serviceAccountAnnotations.ks.amazonaws.com/role-arn"
    value = "arn:aws:iam::858947546191:role/cluster-autoscaler"
    name = "autoDiscovery.clusterName"
    value = var.cluster_name
    name = "autoDiscovery.enabled"
    value = "true"
  }

  set_string {
    name = "cloudProvider"
    value = "aws"
  }

  set {
    name = "awsRegion"
    value = var.AWS_REGION
  }
}