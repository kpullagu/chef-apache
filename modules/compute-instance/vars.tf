variable "tenancy_ocid" {}
variable "compartment_ocid" {}
variable "ssh_public_key" {}
variable "instance_shape" {}
variable "image_ocid" {}
variable "instance_name" {}
variable "instance_count" {}
variable "subnets" {}


variable "boot_strap_file" {
  default = "./userdata/bootstrap.sh"
}

variable "AD" {
  default = "1"
}
