resource "google_storage_bucket_iam_member" "member" {
  bucket = var.bucket_name
  role = var.role
  member = var.member
}

