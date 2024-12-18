locals {
  subnets = {
    public-subnet-1 = {
      name            = "public-subnet-1"
      ip_cidr_range   = "192.168.1.0/24"
      private_access  = false
    },
    public-subnet-2 = {
      name            = "public-subnet-2"
      ip_cidr_range   = "192.168.2.0/24"
      private_access  = false
    },
    private-subnet-1 = {
      name            = "private-subnet-1"
      ip_cidr_range   = "192.168.3.0/24"
      private_access  = true
    },
    private-subnet-2 = {
      name            = "private-subnet-2"
      ip_cidr_range   = "192.168.4.0/24"
      private_access  = true
    }
  }
}

resource "google_compute_network" "network" {
  name      = var.network_name
//  project   = var.project_id
  auto_create_subnetworks = false
}

resource "google_compute_subnetwork" "subnetwork"{
  for_each  = local.subnets

  name      = each.value.name
  ip_cidr_range = each.value.ip_cidr_range
  network   = google_compute_network.network.id
  private_ip_google_access = each.value.private_access
}
