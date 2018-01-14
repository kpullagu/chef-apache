This example will provision a Virtual Machine in Oracle Cloud Infrastructure using Terraform and Configure the Virtual Machine as an Apache Webserver using Chef. The example uses Terraform to bootstrap an OCI instance as a Chef node, register it with an existing Chef server, and run a recipe. When the plan completes, you will have a running web server with content and the correct firewall configuration

Prerequisites
===============
•	knife must be installed and configured in your PATH. This allows the Chef node deletion to work properly when terraform destroy is called.

•	Access to a Chef server to upload the example_webserver recipe to

•	You will also, of course, need access to an Oracle Cloud Infrastructure (OCI) account. If you do not have access, you can request a free trial. To learn more about Oracle OCI, read the Getting Started guide.

Environment Requirements
========================
This example will also install terraform and configure the OCI provider plugin to be used. 
It will also generate SSH public and Private keys required to login to your instance and will also create API sign in keys. 
You can use the public API key to create the required fingerprint from the OCI console.

Using this example
========================

Install_terraform.sh is used to install the terraform and the OCI provider
$ ./install_terraform.sh

Update env.sh with the required information. Most examples use the same set of environment variables so you only need to do this once.
Source env-vars
$ . env.sh

Update vars.tf files with your instance options

Upload the example Chef recipe and its dependencies to your Chef server.
$ cd cookbooks/example_webserver
$ berks install
$ berks upload

Run terraform init.

Run terraform plan.

Run terraform apply.

Navigate to the public IP address (reported by Terraform, above) in your browser.


Files in the configuration
========================

install_teraform.sh
It is used to install and configure terraform to use OCI provider. This will also generate keys in userdata/keys folder

env.sh
Is used to export the environmental variables used in the configuration. These are usually authentication related, be sure to exclude this file from your version control system. It's typical to keep this file outside of the configuration.
Before you plan, apply, or destroy the configuration source the file - $ . env.sh

main.tf
Defines the main file which in turn calls the various modules to create a VCN, to launch a compute VM and then to bootstrap the instance as a Chef node

./userdata/bootstrap
The user-data script that gets injected into the instance on launch. More information on user-data scripts can be found at the cloud-init project.

vars.tf
Defines the variables used in the configuration

provider.tf
Specifies and passes authentication details to the OCI TF provider

./cookbooks/example_webserver/recipes/default.rb
Installs a web server and configures the firewall to allow inbound http and ssh connections.

Running the Sample
========================
The env.sh file needs to be updated with your tenancy specific information

Once you understand the code, have all the software requirements, and have satisfied the environmental requirements you can build your environment.

The first step is to parse all the modules by typing terraform init. This will build out a .terraform directory in your project root. This needs to be done only once.

The next step is to run terraform plan from the command line to generate an execution plan. Examine this plan to see what will be built and that there are no errors.

If you are satisfied, you can build the configuration by typing terraform apply. This will build all of the dependencies and construct an environment to match the project.

Note that Terraform generates a terraform.tfstate and terraform.tfstate.backup file which manage the state of your environment. These files should not be hand edited.

If you want to tear down your environment, you can do that by running terraform destroy

Commands
========================

[opc@orchestration ~]$ sudo yum install git -y

[opc@orchestration ~]$ git clone https://github.com/kpullagu/oci-chef-apache.git

[opc@orchestration ~]$ cd oci-chef-apache

[opc@orchestration oci-chef-apache]$ chmod +x install_terraform.sh

[opc@orchestration oci-chef-apache]$ ./install_terraform.sh

[opc@orchestration oci-chef-apache]$ terraform --version

Terraform v0.11.2

[opc@orchestration oci-chef-apache]$ cat userdata/keys/APIkey_public.txt

upload this key to your OCI console to generate your API fingerprint

[opc@orchestration oci-chef-apache]$ vi env.sh

Modify this file with your OCIDs and the Chef Server Information

[opc@orchestration oci-chef-apache]$ chmod +x env.sh

[opc@orchestration oci-chef-apache]$ . env.sh

[opc@orchestration oci-chef-apache]$ terraform init

[opc@orchestration oci-chef-apache]$ terraform plan -out=plan

[opc@orchestration oci-chef-apache]$ terraform apply "plan"
