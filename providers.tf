﻿provider "aws" {
    access_key = var.AWS_ACCESS_KEY
    secret_key = var.AWS_SECRET_KEY
    region  = var.AWS_REGION
    version = ">= 2.28.1"
}

provider "kubernetes" {
    host = data.aws_eks_cluster.cluster.endpoint
    cluster_ca_certificate = base64decode(data.aws_eks_cluster.cluster.certificate_authority.0.data)
    token = data.aws_eks_cluster_auth.cluster.token
    load_config_file = false
    version = "~> 1.11"
}

terraform {
  required_version = ">= 0.12"
}

provider "random" {
    version = "~> 2.1"
}

provider "local" {
    version = "~> 1.2"
}

provider "null" {
    version = "~> 2.1"
}

provider "template" {
    version = "~> 2.1"
}
