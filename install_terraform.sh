#Get Terraform
version=terraform_0.11.2_linux_amd64.zip
wget "https://releases.hashicorp.com/terraform/0.11.2/$version"
unzip $version -d ~/
rm $version
cd /usr/bin
sudo ln -s $HOME/terraform terraform
cd ~/oci-chef-apache

#Get OCI Plugin for Terraform
wget "https://github.com/oracle/terraform-provider-oci/releases/download/v2.0.6/linux.tar.gz"
tar -xvzf linux.tar.gz
#Add OCI to Terraform Plugins
rm -rf linux_386/ linux_arm/ linux.tar.gz
mkdir ~/.terraform.d
mkdir ~/.terraform.d/plugins
mv linux_amd64/ ~/.terraform.d/plugins/

# Get all necessary keys
# Generate the API Key and the SSH Keys
mkdir userdata/keys
cd userdata/keys/
openssl genrsa -out APIkey.pem 2048
openssl rsa -pubout -in APIkey.pem -out APIkey_public.txt
ssh-keygen -t rsa -N "" -C "rsa-key-MEAN" -f rsa-key-MEAN.ssh
cd ~/oci-chef-apache