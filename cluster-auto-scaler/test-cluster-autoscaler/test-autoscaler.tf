resource "kubernetes_deployment" "test-autoscaler" {
    metadata {
        name = "test-autoscaler"
        namesapce = "default"
        labels = {
            app = "test-autoscaler"
        }
    }

    spec {
        replicas = 10
        selector {
            match_labels = {
                app = "test-autoscaler"
            }
        }
    }

    template {
        metadata {
            labels = {
                service = "nginx"
                app = "test-autoscaler"
            }
        }
        spec {
            container {
                image = "nginx"
                name = "test-autoscaler"
                resources {
                    limits {
                        cpu = "300m"
                        memory = 512mi
                    }
                    requests {
                        cpu = "300m"
                        memory = 512mi
                    }
                }
            }
        }
    }
}