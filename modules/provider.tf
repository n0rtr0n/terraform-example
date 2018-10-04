provider "aws" {
  profile = "${var.AWS_PROFILE}"
  region  = "${var.AWS_REGION}"
}
