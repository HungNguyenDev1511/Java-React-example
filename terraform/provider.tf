provider "vsphere" {
  user           = var.vsphere_user
  password       = var.vsphere_password
  vsphere_server = var.vsphere_server

  # If you have a self-signed cert
  allow_unverified_ssl = true
}

provider "mysql" {
  endpoint = var.mysql_endpoint
  username = var.mysql_user
  password = var.mysql_password
}
