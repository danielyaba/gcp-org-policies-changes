variable "prefix" {
  description = "Prefix naming convension."
  type = string
}

variable "organization_id" {
  description = "Organization ID."
  type        = string
}

variable "project_id" {
  description = "Project ID."
  type        = string
}

variable "region" {
  description = "Region."
  type = string
}

variable "smtp_config" {
  description = "SMTP configuration."
  type = map(object({
    smtp_server = string
    from_email  = string
    group_email = string
  }))
}

