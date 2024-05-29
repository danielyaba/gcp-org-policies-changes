output "cloud_function" {
  description = "Cloud function details."
  value = google_cloudfunctions2_function.function
}

output "gcs_bucket" {
  description = "GCS Bucket details."
  value = google_storage_bucket.bucket
}

output "log_sink" {
  description = "Orgnization Log Sink details"
  value = google_logging_organization_sink.sink
}

output "pubsub_topic" {
  description = "Pub/Sub topic details."
  value = google_pubsub_topic.topic
}

output "service_account" {
  description = "Service Account details."
  value = google_service_account.service_account
}

