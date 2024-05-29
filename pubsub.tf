resource "google_pubsub_topic" "topic" {
  name = "${var.prefix}-topic"
}

resource "google_pubsub_topic_iam_binding" "binding" {
  project = var.project_id
  topic   = google_pubsub_topic.topic.name
  role    = "roles/pubsub.publisher"
  members = [
    "serviceAccount:${google_logging_organization_sink.sink.writer_identity}",
  ]
}