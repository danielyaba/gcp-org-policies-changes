resource "google_storage_bucket" "bucket" {
  name                        = "${var.project_id}-org-policy-changes-gcf-source"
  project = var.project_id
  location                    = var.region
  uniform_bucket_level_access = true
}

resource "google_storage_bucket_object" "bundle" {
  name   = "bundle-${data.archive_file.bundle.output_md5}.zip"
  bucket = google_storage_bucket.bucket.name
  source = data.archive_file.bundle.output_path
}

data "archive_file" "bundle" {
  type             = "zip"
  source_dir       = "./org-policies-changes-function"
  output_path      = "/tmp/bundle-org-policies-changes.zip"
  output_file_mode = "0644"
}