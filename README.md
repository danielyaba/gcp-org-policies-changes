# GCP Organization Policies Changes Module

This module allows simlified creation and managment of alerts on every change in organization policy.  
This module creates Cloud Function v2, GCS bucket, Service-Account, Pub/Sub topic and Log Sink, all with naming convension of ```prefix``` variable.

## Example
```hcl
module "org-policies-changes" {
  source          = "./modules/org-policies-changes"
  organization_id = var.orgnization_id
  project_id      = var.project_id
  prefix          = "org-policies-changes"
  region          = var.region
  smtp_config = {
    smtp_server = "smtp-server.example.com"
    from_email  = "security_alert@example.com"
    group_email = "devops-team@example.com"
  }
}
```
<!-- BEGIN TFDOC -->
## Variables

| name | description | type | required | default |
|---|---|:---:|:---:|:---:|
| [organization_id](variables.tf#L6) | Organization ID. | <code>string</code> | ✓ |  |
| [prefix](variables.tf#L1) | Prefix naming convension. | <code>string</code> | ✓ |  |
| [project_id](variables.tf#L11) | Project ID. | <code>string</code> | ✓ |  |
| [region](variables.tf#L16) | Region. | <code>string</code> | ✓ |  |
| [smtp_config](variables.tf#L21) | SMTP configuration. | <code title="map&#40;object&#40;&#123;&#10;  smtp_server &#61; string&#10;  from_email  &#61; string&#10;  group_email &#61; string&#10;&#125;&#41;&#41;">map&#40;object&#40;&#123;&#8230;&#125;&#41;&#41;</code> | ✓ |  |
<!-- END TFDOC -->
