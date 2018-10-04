resource "aws_key_pair" "tf_key" {
  key_name   = "tf_key"
  public_key = "${var.PUBLIC_KEY}"
}
