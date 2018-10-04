terraform {
  backend "s3" {
    bucket  = "nn-tf-test"
    key     = "tf-production"
    region  = "us-west-2"
    profile = "personal"
  }
}
