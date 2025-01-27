resource "kubernetes_storage_class" "wordpress" {
  metadata {
    name = "efs-sc"
  }
  storage_provisioner = "efs.csi.aws.com"
}
#PV of some size 
resource "kubernetes_persistent_volume" "wordpress" {
  metadata {
    name = "efs-pv"
  }
  spec {
    capacity = {
      storage = "5Gi"
    }
    volume_mode = "Filesystem"
    access_modes = ["ReadWriteMany"]
    persistent_volume_reclaim_policy = "Retain"
    storage_class_name = "efs-sc"
    persistent_volume_source {
      csi {
        driver = "efs.csi.aws.com"
        volume_handle = aws_efs_file_system.efs.id
      }
    }
  }
  depends_on = [ kubernetes_storage_class.wordpress ]
}
#PVC that is used by Deployment
resource "kubernetes_persistent_volume_claim" "wordpress" {
  metadata {
    name = "${var.deployment_name}-pvc"
    namespace = kubernetes_namespace.namespace.metadata[0].name
  }
  spec {
    access_modes = ["ReadWriteMany"]
    storage_class_name = kubernetes_storage_class.wordpress.metadata[0].name
    resources {
      requests = {
        storage = "5Gi"
      }
    }
  }
  depends_on = [ kubernetes_persistent_volume.wordpress ]
}
