resource "google_logging_organization_sink" "sink" {
  org_id           = var.organization_id
  name             = "org-policy-changes"
  description      = "Organization log sink for organizations policy changes - Terraform-managed"
  destination      = "pubsub.googleapis.com/projects/${var.project_id}/topics/${resource.google_pubsub_topic.topic.id}"
  filter           = "protoPayload.methodName=google.cloud.orgpolicy.v2.OrgPolicy.DeletePolicy OR google.cloud.orgpolicy.v2.OrgPolicy.UpdatePolicy OR google.cloud.orgpolicy.v2.OrgPolicy.CreatePolicy OR SetOrgPolicy"
  include_children = true
}