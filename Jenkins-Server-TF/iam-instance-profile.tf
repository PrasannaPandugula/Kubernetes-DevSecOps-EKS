resource "aws_iam_instance_profile" "name" {
  name = "jenkins-iam-instance-profile"
  role = aws_iam_role.iam-role.name
}