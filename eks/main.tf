resource "aws_eks_cluster" "eks_cluster" {
  name     = "${var.cluster_name}-${terraform.workspace}"
  enabled_cluster_log_types = ["api", "audit", "authenticator","controllerManager","scheduler"]
  role_arn = aws_iam_role.eks_cluster.arn

  vpc_config {
    subnet_ids = concat(var.public_subnets, var.private_subnets)
  }

  tags = {
    Name = "eks_cluster_${terraform.workspace}"
  }
  depends_on = [
    aws_iam_role_policy_attachment.AmazonEKSClusterPolicy,
    aws_iam_role_policy_attachment.AmazonEKSServicePolicy
  ]
}
