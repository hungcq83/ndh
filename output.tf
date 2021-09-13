output "ec2_private_ip" {
    value = aws_instance.ndh_pipeline_instance.private_ip
}

output "ec2_public_ip" {
    value = aws_instance.ndh_pipeline_instance.public_ip
}