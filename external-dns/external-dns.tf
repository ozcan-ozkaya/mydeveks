resource "helm_release" "external-dns" {
  name       = "external-dns"
  repository = "https://charts.bitnami.com/bitnami"
  chart      = "bitnami/external-dns"
  version    = "3.2.3"
  namespace  = "kube-system"

#  values = [
#    "${file("alb-ingress-controller-chart-values.yaml")}"
#  ]

  set {
    name  = "sources"
    value = "ingress"
  }

  set {
    name  = "provider"
    value = "aws"
  }

  set {
    name  = "aws.region"
    value = var.AWS_REGION
  }
#  Uncomment this if the  extermal-dns should watch only one specific namespace
  set {
    name  = "namespace"
    value = var.EXTDNS_NAMESPACE
  }

  set {
    name  = "aws.zoneType"
    value = "public"
  }

  set {
    name  = "aws.assumeRoleArn"
    value = "" #When using the AWS provider, assume role by specifying --aws-assume-role to the external-dns daemon
  }

  set {
    name = "dryRun"
    value = "false"
  }

  set {
    name = "policy"
    value = "sync" # if you want prevent external-dns deleting records use "upsert-only instead"
  }

  set {
    name = "registry"
    value = "txt" # registry methods, "txt" or "noop"
  }

  set {
    name = "logLevel"
    value = "info" # Verbosity of the logs (options: panic, debug, info, warn, error, fatal)
  }

  set {
    name = "logFormat"
    value = "text" # Which format to output logs in (options: text, json)
  }

  set {
    name = "txtOwnerId"
    value = var.TXT_OWNER_ID
  }

  set {
    name = "domainFilters[0]"
    value = var.HOSTED_ZONE_NAME
  }

  set {
    name = "replicas" # Desired number of ExternalDNS replicas
    value = 1
  }

  set {
    name = "serviceTypeFilter"
    value = ""
  }
}