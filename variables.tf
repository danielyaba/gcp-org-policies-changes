variable "organization_id" {
  type        = string
  description = "Organization ID."
}

variable "project_id" {
  type        = string
  description = "Project ID."
}

variable "region" {
  type = string
  description = "Region."
}

variable "smtp_config" {
  description = "SMTP configuration."
  type = map(object({
    smtp_server = string
    from_email  = string
    group_email = string
  }))
}

