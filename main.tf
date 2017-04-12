#
# DO NOT DELETE THESE LINES!
#
# Your AMI ID is:
#
#     ami-eea9f38e
#
# Your subnet ID is:
#
#     subnet-7e08481a
#
# Your security group ID is:
#
#     sg-834d35e4
#
# Your Identity is:
#
#     autodesk-dinosaur
#

terraform {
  backend "atlas" {
    name = "willhou/training"
  }
}

variable "aws_access_key" {}
variable "aws_secret_key" {}

variable "region" {
  default = "us-west-1"
}

provider "aws" {
  access_key = "${var.aws_access_key}"
  secret_key = "${var.aws_secret_key}"
  region     = "${var.region}"
}

variable "num_webs" {
  default = "3"
}

resource "aws_instance" "web" {
  ami           = "ami-eea9f38e"
  count         = "${var.num_webs}"
  instance_type = "t2.micro"

  subnet_id              = "subnet-7e08481a"
  vpc_security_group_ids = ["sg-834d35e4"]

  tags {
    identity = "autodesk-dinosaur"
    Function = "AD"
    use      = "Prod"
    Name     = "Web $(count.index+1}/${var.num_webs}"
  }
}

output "public_ip" {
  value = ["${aws_instance.web.*.public_ip}"]
}

output "public_dns" {
  value = ["${aws_instance.web.*.public_dns}"]
}
