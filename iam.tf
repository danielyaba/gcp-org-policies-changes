resource "google_service_account" "service_account" {
  project      = var.project_id
  account_id   = "${var.prefix}-sa"
  display_name = "${var.prefix}-sa"
}

resource "google_cloudfunctions2_function_iam_binding" "binding" {
  project        = var.project_id
  location       = google_cloudfunctions2_function.function.location
  cloud_function = google_cloudfunctions2_function.function.name
  role           = "roles/run.invoker"
  members        = google_service_account.service_account.member
}


