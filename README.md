# GCP Organization Policies Changes Module

This module allows simlified creation and managment of alerts on every change in organization policy.  
This module creates Cloud Function v2, GCS bucket, Service-Account, Pub/Sub topic and Log Sink, all with name naming convesion of "org-policies-changes".

## Example
```hcl
module "org-policies-changes" {
  source = "./modules/org-policies-changes"
  organization_id = var.orgnization_id
  project_id = var.project_id
  region = var.region
  smtp_config = {
    smtp_server = "smtp-server.example.com"
    from_email  = "security_alert@example.com"
    group_email = "devops-team@example.com"
  }
}
```
