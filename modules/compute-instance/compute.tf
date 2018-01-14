resource "oci_core_instance" "compute_instance" {
  availability_domain = "${lookup(data.oci_identity_availability_domains.ADs.availability_domains[var.AD - 1],"name")}"
  compartment_id      = "${var.compartment_ocid}"
  display_name        = "ChefNode-ApacheVM"
  hostname_label      = "ApacheWebServer-VM"
  image               = "${var.image_ocid}"
  shape               = "${var.instance_shape}"
  subnet_id           = "${var.subnets}"
  count               = "${var.instance_count}"

  metadata = {
    ssh_authorized_keys = "${var.ssh_public_key}"
    user_data = "${base64encode(file(var.boot_strap_file))}"
  }

  timeouts = {
    "create" = "60m"
  }
}
