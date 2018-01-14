variable "VPC-CIDR" {
  default = "10.0.0.0/16"
}

data "oci_identity_availability_domains" "ADs" {
  compartment_id = "${var.tenancy_ocid}"
}

resource "oci_core_virtual_network" "TF_VCN" {
  cidr_block = "10.0.0.0/16"
  dns_label = "tfvcn"
  compartment_id = "${var.compartment_ocid}"
  display_name = "TF_VCN"
}

resource "oci_core_internet_gateway" "TF_IG" {
  compartment_id = "${var.compartment_ocid}"
  display_name = "TF_IG"
  vcn_id = "${oci_core_virtual_network.TF_VCN.id}"
}

resource "oci_core_route_table" "TF_RT" {
  compartment_id = "${var.compartment_ocid}"
  vcn_id = "${oci_core_virtual_network.TF_VCN.id}"
  display_name = "TF_RT"
  route_rules {
    cidr_block = "0.0.0.0/0"
    network_entity_id = "${oci_core_internet_gateway.TF_IG.id}"
  }
}

resource "oci_core_security_list" "TF_SL_Public" {
  compartment_id = "${var.compartment_ocid}"
  display_name = "TF_SL_Public"
  vcn_id = "${oci_core_virtual_network.TF_VCN.id}"
  egress_security_rules = [{
    destination = "0.0.0.0/0"
    protocol = "6"
  }]
  // allow inbound http traffic
  ingress_security_rules = {
    tcp_options {
      "max" = 80
      "min" = 80
    }
    protocol = "6"
    source = "0.0.0.0/0"
  }
  // allow inbound ssh traffic
  ingress_security_rules {
    protocol = "6" // tcp
    source = "0.0.0.0/0"
    stateless = false

    tcp_options {
      "min" = 22
      "max" = 22
    }
  }

  // allow inbound icmp traffic of a specific type
  ingress_security_rules {
    protocol  = 1
    source    = "0.0.0.0/0"
    stateless = true

    icmp_options {
      "type" = 3
      "code" = 4
    }
}

}

resource "oci_core_subnet" "TF_Public_SubnetAD1" {
  availability_domain = "${lookup(data.oci_identity_availability_domains.ADs.availability_domains[0],"name")}"
  cidr_block = "10.0.1.0/24"
  display_name = "TF_Public_SubnetAD1"
  dns_label = "tfsub1"
  compartment_id = "${var.compartment_ocid}"
  vcn_id = "${oci_core_virtual_network.TF_VCN.id}"
  dhcp_options_id = "${oci_core_virtual_network.TF_VCN.default_dhcp_options_id}"
  route_table_id = "${oci_core_route_table.TF_RT.id}"
  security_list_ids = ["${oci_core_security_list.TF_SL_Public.id}"]
}

resource "oci_core_subnet" "TF_Public_SubnetAD2" {
  availability_domain = "${lookup(data.oci_identity_availability_domains.ADs.availability_domains[1],"name")}"
  cidr_block = "10.0.2.0/24"
  display_name = "TF_Public_SubnetAD2"
  dns_label = "tfsub2"
  compartment_id = "${var.compartment_ocid}"
  vcn_id = "${oci_core_virtual_network.TF_VCN.id}"
  route_table_id = "${oci_core_route_table.TF_RT.id}"
  dhcp_options_id = "${oci_core_virtual_network.TF_VCN.default_dhcp_options_id}"
  security_list_ids = ["${oci_core_security_list.TF_SL_Public.id}"]
}

resource "oci_core_subnet" "TF_Public_SubnetAD3" {
  availability_domain = "${lookup(data.oci_identity_availability_domains.ADs.availability_domains[2],"name")}"
  cidr_block = "10.0.3.0/24"
  display_name = "TF_Public_SubnetAD3"
  dns_label = "tfsub3"
  compartment_id = "${var.compartment_ocid}"
  vcn_id = "${oci_core_virtual_network.TF_VCN.id}"
  route_table_id = "${oci_core_route_table.TF_RT.id}"
  security_list_ids = ["${oci_core_security_list.TF_SL_Public.id}"]
  dhcp_options_id = "${oci_core_virtual_network.TF_VCN.default_dhcp_options_id}"
}
