resource "google_project_iam_member" "example" {
  project = var.project_id
  role    = "roles/viewer"
  member  = "user:basivireddy1212@gmail.com"
}