resource "google_compute_network" "vpc_network" {
  name = "dashboard-vpc"
}

resource "google_compute_subnetwork" "subnet" {
  name          = "dashboard-subnet"
  ip_cidr_range = "10.0.0.0/16"
  region        = var.region
  network       = google_compute_network.vpc_network.id
}
