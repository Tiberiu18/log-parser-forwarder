resource "tls_private_key" "ec2_key" {
  algorithm = "RSA"
  rsa_bits  = 4096

}


resource "null_resource" "save_private_key" {
  provisioner "local-exec" {
    command = <<EOT
echo '${tls_private_key.ec2_key.private_key_pem}' > ${path.module}/id_rsa
chmod 600 ${path.module}/id_rsa
EOT
  }

  triggers = {
    private_key_pem = tls_private_key.ec2_key.private_key_pem
  }

}


