module "asg" {
  source = "../../../modules/asg"

  NAME        = "${var.ENVIRONMENT}-asg"
  ENVIRONMENT = "${var.ENVIRONMENT}"

  # Launch configuration
  LAUNCH_CONFIGURATION_NAME = "${var.ENVIRONMENT}-lc"
  ASG_AMI                   = "${lookup(local.ASG_AMIS, var.AWS_REGION)}"
  EC2_INSTANCE_TYPE         = "t2.medium"
  SECURITY_GROUPS           = ["${module.instance-security-group.this_security_group_id}"]
  KEY_NAME                  = "${aws_key_pair.staging-asg-key.key_name}"
  VOLUME_SIZE               = "50"
  VOLUME_TYPE               = "gp2"
  TARGET_GROUP_ARNS         = ["${module.alb.target_group_arns}"]

  # Auto scaling group
  ASG_NAME         = "${var.ENVIRONMENT}-asg"
  SUBNETS          = ["${module.vpc.private_subnets}"] #this is where Terraform gets REAAALLLY powerful
  MIN_SIZE         = 3
  MAX_SIZE         = 10
  DESIRED_CAPACITY = 3

  # installs Docker and echo image to demonstrate LB in multi-AZ
  USER_DATA = "${data.template_file.user_data.rendered}"
}
