module "vcn" {
  source = "./modules/vcn"
  tenancy_ocid = "${var.tenancy_ocid}"
  compartment_ocid = "${var.compartment_ocid}"
}

module "compute-instance" {
  source = "./modules/compute-instance"
  tenancy_ocid = "${var.tenancy_ocid}"
  compartment_ocid = "${var.compartment_ocid}"
  ssh_public_key = "${var.ssh_public_key}"
  instance_name = "apache-vm"
  subnets = "${module.vcn.subnet1_ocid}"
  instance_count = "${var.instance_count}"
  instance_shape = "${var.instance_shape}"
  image_ocid = "${var.instance_image_ocid[var.region]}"

}
module "chef-apache-config" {
  source = "./modules/chef-apache-config"
  tenancy_ocid = "${var.tenancy_ocid}"
  compartment_ocid = "${var.compartment_ocid}"
  apache-vm-public-ip = "${module.compute-instance.items_comma}"
  instance_count = "${var.instance_count}"
  ssh_private_key = "${var.ssh_private_key}"
}

output "Apache WebServer URL" {
  value = "http://${module.compute-instance.InstancePublicIP[0]}"
}
