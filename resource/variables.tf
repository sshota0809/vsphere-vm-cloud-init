data "vsphere_datacenter" "dc" {
  name = "your-dc-name"
}

data "vsphere_compute_cluster" "cluster" {
  name          = "your-cluster-name"
  datacenter_id = "${data.vsphere_datacenter.dc.id}"
}

data "vsphere_datastore" "storage" {
  name          = "your-storage-name"
  datacenter_id = data.vsphere_datacenter.dc.id
}

data "vsphere_resource_pool" "infra" {
  name          = "your-cluster-name/Resources/infra"
  datacenter_id = data.vsphere_datacenter.dc.id
}

data "vsphere_network" "server_nw" {
  name          = "your-network-name"
  datacenter_id = data.vsphere_datacenter.dc.id
}
