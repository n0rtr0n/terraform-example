locals {
  LOG_BUCKET_NAME = "${var.LOG_BUCKET_NAME}-${data.aws_caller_identity.current.account_id}-${data.aws_region.current.name}"

  HTTP_TCP_LISTENERS_COUNT = 1

  HTTP_TCP_LISTENERS = "${list(
                            map(
                                "port", 80,
                                "protocol", "HTTP",
                            ),
  )}"

  AZS = {
    us-east-1 = ["us-east-1a", "us-east-1b", "us-east-1c"]
    us-west-1 = ["us-west-1a", "us-east-1c"]
    us-west-2 = ["us-west-2a", "us-west-2b", "us-west-2c"]
  }

  TARGET_GROUPS_COUNT = 1

  TARGET_GROUPS = "${list(
                        map("name", "staging-targets",
                            "backend_protocol", "HTTP",
                            "backend_port", 80,
                        ),
  )}"

  # Amazon Linux 2
  ASG_AMIS = {
    us-east-1 = "ami-04681a1dbd79675a5"
    us-west-1 = "ami-0782017a917e973e7"
    us-west-2 = "ami-6cd6f714"
  }

  //  STATE_BUCKET_NAME = "${var.bucket}"
  //  STATE_LOCKING_TABLE = "${var.dynamodb_table}"
  #STATE_BUCKET_NAME = "${var.STATE_BUCKET_NAME}-${data.aws_caller_identity.current.account_id}-${data.aws_region.current.name}"
  #STATE_LOCKING_TABLE = "${var.STATE_LOCKING_TABLE_NAME}-${data.aws_caller_identity.current.account_id}-${data.aws_region.current.name}"
}
