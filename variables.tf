variable "organization_id" {
  type        = string
  description = "The organization id."
}

variable "project_id" {
  type        = string
  description = "Project id to deploy resources to."
}

variable "region" {
  type = string
}

variable "smtp_config" {
  type = map(object({
    smtp_server = string
    from_email  = string
    group_email = string
  }))
}