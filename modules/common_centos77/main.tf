variable datacenter_id {}
variable hostname {}
variable network_address {}
variable network_gateway {}
variable resource_pool_id {}
variable datastore_id {}
variable network_id {}
variable cpu_num {}
variable ram_num {}
variable disk_size {}

data "vsphere_virtual_machine" "template" {
  name          = "template-centos7.7-cloud-init"
  datacenter_id = "${var.datacenter_id}"
}

data "template_file" "test_cloud_init_userdata" {
  template = "${file("${path.module}/cloud-init/userdata.yaml")}"
}

data "template_file" "test_cloud_init_metadata" {
  template = "${file("${path.module}/cloud-init/metadata.yaml")}"
  
  vars = {
    instance_name = "${var.hostname}"
    network_address = "${var.network_address}"
    network_gateway = "${var.network_gateway}"
  }
}

resource "vsphere_virtual_machine" "test_cloud_init" {
  name             = "${var.hostname}"
  resource_pool_id = "${var.resource_pool_id}"
  datastore_id     = "${var.datastore_id}"

  num_cpus = "${var.cpu_num}"
  memory   = "${var.ram_num}"
  guest_id = "${data.vsphere_virtual_machine.template.guest_id}"

  scsi_type = "${data.vsphere_virtual_machine.template.scsi_type}"

  network_interface {
    network_id   = "${var.network_id}"
    adapter_type = "${data.vsphere_virtual_machine.template.network_interface_types[0]}"
  }

  disk {
    label            = "${var.hostname}-disk0"
    size             = "${var.disk_size}"
    eagerly_scrub    = "${data.vsphere_virtual_machine.template.disks.0.eagerly_scrub}"
    thin_provisioned = "${data.vsphere_virtual_machine.template.disks.0.thin_provisioned}"
  }

  clone {
    template_uuid = "${data.vsphere_virtual_machine.template.id}"
  }

  extra_config = {
    "guestinfo.userdata"          = "${data.template_file.test_cloud_init_userdata.rendered}"
    "guestinfo.metadata"          = "${data.template_file.test_cloud_init_metadata.rendered}"
  }

}
