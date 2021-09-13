variable vpc_id {}

resource "aws_security_group" "ec2_rds_access" {
  name        = "ec2_rds_access"
  description = "Allow EC2 instance to access to postgres DB"
  vpc_id      = var.vpc_id

  ingress = [
    {
      description      = "Allow TCP/5432 access to Postgres DB from EC2"
      from_port        = 5432
      to_port          = 5432
      protocol         = "tcp"
      cidr_blocks      = ["${aws_instance.ndh_pipeline_instance.private_ip}/32"]
      ipv6_cidr_blocks = []
      prefix_list_ids  = []
      security_groups  = []
      self             = false 
    }
  ]
}
