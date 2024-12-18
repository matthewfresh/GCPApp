resource "google_storage_bucket" "static" {
  name = var.bucket_name
  location = var.region
  storage_class = "STANDARD"
  uniform_bucket_level_access = true
  force_destroy = true
}

# Grant public read access to the bucket
resource "google_storage_bucket_iam_member" "public_access" {
  bucket = google_storage_bucket.static.name
  role   = "roles/storage.objectViewer"
  member = "allUsers"  # Makes objects in the bucket publicly accessible
}