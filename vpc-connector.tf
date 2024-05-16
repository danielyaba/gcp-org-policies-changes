resource "google_vpc_access_connector" "connector" {
  project = module.project.project_id
  name    = "vpc-connector"
  subnet {
    name       = "vpc-connector" # must be /28
    project_id = var.project_id
  }
  machine_type   = "e2-micro"
  min_instances  = 2
  max_instances  = 10
  max_throughput = 1000
  region         = var.region
}