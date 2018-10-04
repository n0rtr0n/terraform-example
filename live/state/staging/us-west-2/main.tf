provider "aws" {
  region  = "${var.AWS_REGION}"
  profile = "${var.AWS_PROFILE}"
}

module "state" {
  source = "../../../../modules/state"

  ENVIRONMENT         = "${var.ENVIRONMENT}"
  STATE_BUCKET_NAME   = "${var.STATE_BUCKET_NAME}"
  STATE_LOCKING_TABLE = "${var.STATE_LOCKING_TABLE}"
  AWS_REGION          = "${var.AWS_REGION}"
}
