provider google {
  # version = "~> 2.11"
  project = "your-gcp-project"
  region  = "asia-northeast1"
}

provider google-beta {
  # version = "~> 2.11"
  project = "your-gcp-project"
  region  = "asia-northeast1"
}

provider "vsphere" {
  # cluster name = VSPHERE_SERVER
  # user name = VSPHERE_USER
  # user password = VSPHERE_PASSWORD
  
  # If you have a self-signed cert
  allow_unverified_ssl = true
}
