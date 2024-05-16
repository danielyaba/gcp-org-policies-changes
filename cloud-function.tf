resource "google_cloudfunctions2_function" "function" {
  name        = "org-policy-changes-cf"
  project     = var.project_id
  location    = var.region
  description = "Cloud function to sending email alerts"
  build_config {
    entry_point = "get_topic_massage"
    environment_variables = {
      SMTP_SERVER = var.smtp_configs.smtp_server
      FROM_EMAIL  = var.smtp_configs.from_email
      GROUP_EMAIL = var.smtp_configs.group_email
    }
    source {
      storage_source {
        bucket = google_storage_bucket.bucket
        object = google_storage_bucket_object.bundle.name
      }
    }
  }
  service_config {
    service_account_email = google_service_account.service_account.email
    environment_variables = {
      SMTP_SERVER = var.smtp_configs.smtp_server
      FROM_EMAIL  = var.smtp_configs.from_email
      GROUP_EMAIL = var.smtp_configs.group_email
    }
    ingress_settings = "ALLOW_INTERNAL_ONLY"
  }
  event_trigger {
    trigger_region        = var.region
    event_type            = "google.cloud.pubsub.topic.v1.messagePublished"
    pubsub_topic          = google_pubsub_topic.topic.id
    retry_policy          = "RETRY_POLICY_DO_NOT_RETRY"
    service_account_email = google_service_account.service_account.email
  }
}


