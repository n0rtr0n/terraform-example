resource "aws_ami_copy" "encrypted" {
  name              = "encrypted-amazon-linux"
  description       = "AMI Linux with encrypted volume"
  source_ami_id     = "${lookup(local.ASG_AMIS, var.AWS_REGION)}"
  source_ami_region = "${var.AWS_REGION}"
  encrypted         = "true"

  tags = {
    Name        = "Amazon-Linux-Encrypted-${var.ENVIRONMENT}"
    Terraform   = "true"
    Environment = "${var.ENVIRONMENT}"
  }
}
