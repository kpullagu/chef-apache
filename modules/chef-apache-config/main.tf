resource "null_resource" "chef-apache-config" {
  count = "${var.instance_count}"

  provisioner "chef" {
      server_url = "${var.chef_server}"
      node_name = "${var.chef_node_name}"
      run_list = "${var.chef_recipes}"
      user_name = "${var.chef_user}"
      user_key = "${file(var.chef_key)}"
      recreate_client = true
      fetch_chef_certificates = true
      connection {
        host = "${element(split(",", var.apache-vm-public-ip), count.index)}"
        user = "opc"
        private_key = "${var.ssh_private_key}"
        type = "ssh"
        timeout = "3m"
      }
    }

    #You will need knife.rb in your current path in order for this command to complete successfully.
    provisioner "local-exec" {
      when = "destroy"
      on_failure = "continue"
      command = "knife node delete ${var.chef_node_name} -y",
  }

}
