resource "aws_eks_node_group" "EKSNodeGroup" {
  cluster_name    = var.cluster-name
  node_group_name = var.node-group-name
  node_role_arn   = aws_iam_role.NodeGroupRole.arn
  subnet_ids      = [data.aws_subnet.subnet.id, aws_subnet.public-subnet2.id]

  scaling_config {
    desired_size = 2
    max_size     = 3
    min_size     = 1
  }

  instance_types = ["m7i-flex.large"]
  disk_size      = 20

  depends_on = [aws_iam_policy_attachment.AmazonEC2ContainerRegistryReadOnly,
    aws_iam_role_policy_attachment.AmazonEKS_CNI_Policy,
    aws_iam_policy_attachment.AmazonEKSWorkerNodePolicy]
}