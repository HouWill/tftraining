# Configure the DNS Provider
provider "dnsimple" {
  update {
    server        = "192.168.0.1"
    key_name      = "example.com."
    key_algorithm = "hmac-md5"
    key_secret    = "3VwZXJzZWNyZXQ="
  }

resource "dnsimple_record" "www" {
    domain = "will.com."
    name = "coolkid"
    type = "A"
    value = "${aws_instance.web.0.public)}"
    }
}

# Alternatively
value = "${element(aws_instance.web.*.public_ip, count.index)}
