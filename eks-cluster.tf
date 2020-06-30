module "eks" {
  source  = "terraform-aws-modules/eks/aws"
  version = "12.1.0"
  cluster_name = var.cluster_name
  cluster_version = "1.16"
  subnets = module.vpc.private_subnets
  enable_irsa = true

  tags = {
      Environment = "dev"
      ResourceGroup = var.cluster_name
  }

  vpc_id = module.vpc.vpc_id

worker_groups = [
    {
        name = "worker-group-1"
        instance_type = "t2.small"
        additional_userdata = "echo foo bar"
        asg_desired_capacity = 1
        additional_security_group_ids = [aws_security_group.worker_group_mgmt_one.id]
        tags = [
            {
                "key" = "k8s.io/cluster-autoscaler/enabled"
                "propagate_at_launch" = "false"
                "value" = "true"
            },
            {
                "key" = "k8s.io/cluster-autoscaler/${var.cluster_name}"
                "propagate_at_launch" = "false"
                "value" = "true"
            }
        ]
    },
    {
        name = "worker-group-2"
        instance_type = "t2.small"
        additional_userdata = "echo foo bar"
        asg_desired_capacity = 1
        additional_security_group_ids = [aws_security_group.worker_group_mgmt_two.id]
        tags = [
            {
                "key" = "k8s.io/cluster-autoscaler/enabled"
                "propagate_at_launch" = "false"
                "value" = "true"
            },
            {
                "key" = "k8s.io/cluster-autoscaler/${var.cluster_name}"
                "propagate_at_launch" = "false"
                "value" = "true"
            }
        ]
    }
  ]
}

data "aws_eks_cluster" "cluster" {
    name = module.eks.cluster_id
}

data "aws_eks_cluster_auth" "cluster" {
    name = module.eks.cluster_id
}

data "aws_caller_identity" "current" {}