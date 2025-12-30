#creating a private key and storing it in a local file
# https://registry.terraform.io/providers/hashicorp/tls/latest/docs/resources/private_key 

resource "tls_private_key" "pvtkey" {
 algorithm = "RSA"
 rsa_bits = 4096
}

resource "local_file" "key_details" {
  filename = "/root/key.txt"
  content = "${tls_private_key.pvtkey.private_key_pem}"
}


# signing too

resource "local_file" "key_data" {
        filename       = "/tmp/.pki/private_key.pem"
        content = tls_private_key.private_key.private_key_pem
        file_permission =  "0400"
}
resource "tls_private_key" "private_key" {
  algorithm   = "RSA"
  rsa_bits  = 4096
}
resource "tls_cert_request" "csr" {
  private_key_pem = tls_private_key.private_key.private_key_pem
  depends_on = [ local_file.key_data ]

  subject {
    common_name  = "samit.com"
    organization = "Sam IT Consulting Services"
  }
}
