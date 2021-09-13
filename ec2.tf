variable ec2_ami {}
variable ec2_instance_type {}

resource "aws_instance" "ndh_pipeline_instance" {
  ami           = var.ec2_ami
  instance_type = var.ec2_instance_type
  iam_instance_profile = aws_iam_instance_profile.ndh_pipeline_instance_profile.name
}
