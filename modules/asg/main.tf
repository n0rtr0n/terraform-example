module "asg" {
  source  = "terraform-aws-modules/autoscaling/aws"
  version = "2.8.0"

  name = "${var.NAME}"

  # Launch configuration
  lc_name = "${var.LAUNCH_CONFIGURATION_NAME}"

  image_id        = "${var.ASG_AMI}"
  instance_type   = "${var.EC2_INSTANCE_TYPE}"
  security_groups = "${var.SECURITY_GROUPS}"
  key_name        = "${var.KEY_NAME}"

  root_block_device = [
    {
      volume_type = "${var.VOLUME_TYPE}"
      volume_size = "${var.VOLUME_SIZE}"
    },
  ]

  target_group_arns = "${var.TARGET_GROUP_ARNS}"

  # Auto scaling group
  asg_name                  = "${var.ASG_NAME}"
  vpc_zone_identifier       = "${var.SUBNETS}"          #this isn't totally clear, but is asking for a list of subnets
  health_check_type         = "EC2"
  min_size                  = "${var.MIN_SIZE}"
  max_size                  = "${var.MAX_SIZE}"
  desired_capacity          = "${var.DESIRED_CAPACITY}"
  wait_for_capacity_timeout = "10m"

  #TODO: merge with additional tags
  tags = [
    {
      key                 = "Environment"
      value               = "${var.ENVIRONMENT}"
      propagate_at_launch = true
    },
    {
      key                 = "Terraform"
      value               = "true"
      propagate_at_launch = true
    },
  ]

  user_data = "${var.USER_DATA}"
}
