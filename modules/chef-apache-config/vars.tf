variable "tenancy_ocid" {}
variable "compartment_ocid" {}
variable "apache-vm-public-ip" {}
variable "instance_count" {}

variable "ssh_private_key" {
  description = "Instance Private Key"
  default ="userdata/keys/rsa-key-MEAN.ssh"
}
#Chef Configuration Variables
variable "chef_user" {
  description = "User name to access your Chef server"
  default = "<Chef user>"
}
variable "chef_key" {
  description = "Path to Private Key for your chef_user to access Chef server"
  default = "<SSL certificate path>"
}
variable "chef_node_name" {
  description = "Chef Server Node Name, must be unique"
  default = "<Chef node name>"
}
variable "chef_recipes" {
  description = "List of recipes for Chef to run"
  type = "list"
  default = ["recipe[example_webserver::default]"]
}
variable "chef_server" {
  description = "URL for your chef server"
  default = "https://<Chef server IP>/organizations/<Organization>"
}
