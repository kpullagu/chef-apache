### Authentication details
export TF_VAR_tenancy_ocid="<tenancy OCID>"
export TF_VAR_user_ocid="<user OCID>"
export TF_VAR_fingerprint="<PEM key fingerprint>"

### Region
export TF_VAR_region="<region in which to operate, example: us-phoenix-1, us-ashburn-1, eu-frankfurt-1>"

### Compartment
export TF_VAR_compartment_ocid="<compartment OCID>"

### Public/private keys used on the instance
export TF_VAR_ssh_public_key=$(cat userdata/keys/rsa-key-MEAN.ssh.pub)
export TF_VAR_ssh_private_key=$(cat userdata/keys/rsa-key-MEAN.ssh)
## NOTE: These are not your api keys. More info on the right keys see
## https://docs.us-phoenix-1.oraclecloud.com/Content/Compute/Tasks/managingkeypairs.htm
export TF_VAR_private_key_path="userdata/keys/APIkey.pem"

## Specific to this example
### Choose a subnet that exists in the AD and compartment you are launching the instance in
#export TF_VAR_SubnetOCID="ocid1.subnet.oc1.phx.aaaaaaaa4ju5iltxjvnmwnmqa2ewcl3ij3ms2yiaewp3nswezs3w3qjbc2sq"
export TF_VAR_AD="1"


# Path to Chef SSL certificate
export TF_VAR_chef_key="<SSL certificate path>"
export TF_VAR_chef_user="<Chef user>"
export TF_VAR_chef_node_name="<Chef node name>"
export TF_VAR_chef_recipes='["recipe[example_webserver::default]"]'
export TF_VAR_chef_server="https://<Chef server IP>/organizations/<Organization>"
