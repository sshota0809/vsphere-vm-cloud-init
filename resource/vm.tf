module "test-vm" {
    source            = "../modules/common_centos77"

    datacenter_id     = "${data.vsphere_datacenter.dc.id}"
    hostname          = "test-vm"
    resource_pool_id  = "${data.vsphere_resource_pool.infra.id}"
    network_address   = "10.0.0.1/24"
    network_gateway   = "10.0.1.254"
    datastore_id      = "${data.vsphere_datastore.storage.id}"
    network_id        = "${data.vsphere_network.server_nw.id}"
    cpu_num           = 2
    ram_num           = 4096
    disk_size         = 100
}
