#locals {
#    apps = { for k, a in var.apps : k => a if lookup(a, "stage", 10) <= var.target_stage }
#}

/*
resource "google_compute_region_disk" "region_disk" {
    for-each = var.region_disks

    name = lookup(each.value, "name", null)
    snapshot = lookup(each.value, "snapshot", null)
    type = lookup(each.value, "type", null)
    region = var.region
    size = lookup(each.value, "size", null)

    replica_zones = slice(var.zones, 0, 2)
}
*/

module "buckets" {
  source              = "git::https://github.com/basivireddy1212/terraform-apps-lib//bucket"
  for_each            = var.buckets
  name                = each.value.name
  location            = each.value.location
  environment         = var.environment
  project_id          = var.project_id
  organization_labels = var.organization_labels

}


