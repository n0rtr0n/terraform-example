resource "aws_key_pair" "staging-asg-key" {
  key_name   = "staging-asg-key"
  public_key = "${var.PUBLIC_KEY}" #TODO: switch out this key
}
