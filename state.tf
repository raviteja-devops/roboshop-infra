terraform {
  backend "s3" {}
}

# remaining values are coming from state.tfvars
# we cannot variablize the terraform state.tf file according to the ENVIRONMENT we needed
# so, based on ENVIRONMENT we are running, we are going to pick that ENVIRONMENT BACKEND FILES 'state.tfvars'