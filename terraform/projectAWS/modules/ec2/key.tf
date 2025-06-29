resource "aws_key_pair" "my_key" {
  key_name   = "log-parser"
  public_key = file("~/.ssh/id_rsa.pub")

}
