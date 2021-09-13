locals {
    role_name = "ec2-rds-s3"

}

data "aws_iam_policy_document" "instance-assume-role-policy" {
  statement {
    actions = ["sts:AssumeRole"]

    principals {
      type        = "Service"
      identifiers = ["ec2.amazonaws.com"]
    }
  }
}

resource "aws_iam_role" "ndh_pipeline" {
    name = "NDH-Pipeline"
    assume_role_policy = data.aws_iam_policy_document.instance-assume-role-policy.json
    managed_policy_arns = ["arn:aws:iam::aws:policy/AdministratorAccess"]
}

resource "aws_iam_instance_profile" "ndh_pipeline_instance_profile" {
  name = "ndh_pipeline_instance_profile"
  role = aws_iam_role.ndh_pipeline.name
}