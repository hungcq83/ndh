variable landing_zone {}
variable s3_bucket {}
variable kms_key_id {}

resource "aws_s3_bucket" "ndh_s3_bucket" {
  bucket = "${var.landing_zone}-${var.s3_bucket}"
  acl    = "private"

  server_side_encryption_configuration {
    rule {
      apply_server_side_encryption_by_default {
        kms_master_key_id = var.kms_key_id
        sse_algorithm     = "aws:kms"
      }
    }
  }

  tags = {
    Name        = "NDH Data bucket"
  }
}