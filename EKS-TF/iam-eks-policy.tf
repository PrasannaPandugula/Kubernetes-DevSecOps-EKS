resource "aws_iam_policy_attachment" "AmazonEKSClusterPolicy " {
  name       = "AmazonEKSClusterPolicy"
  roles      = [aws_iam_role.EKSClusterRole.name]
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSClusterPolicy"
}

resource "aws_iam_policy_attachment" "AmazonEKSWorkerNodePolicy" {
  name       = "AmazonEKSWorkerNodePolicy"
  roles      = [aws_iam_role.NodeGroupRole]
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSWorkerNodePolicy"
}

resource "aws_iam_policy_attachment" "AmazonEC2ContainerRegistryReadOnly " {
  name       = "AmazonEC2ContainerRegistryReadOnly"
  roles      = [aws_iam_role.NodeGroupRole]
  policy_arn = "arn:aws:iam::aws:policy/AmazonEC2ContainerRegistryReadOnly"
}

resource "aws_iam_role_policy_attachment" "AmazonEKS_CNI_Policy" {
  role       = [aws_iam_role.NodeGroupRole]
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKS_CNI_Policy"
}