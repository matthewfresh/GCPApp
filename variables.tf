variable "project_id" {
  description = "The project ID"
  type        = string
}

variable "region" {
  description = "The GCP deployment region"
  type        = string
}

variable "network_name" {
  description = "The name of vpc in GCP"
  type        = string
}

variable "bucket_name" {
  description = "The name of cloud storage bucket in GCP"
  type        = string
}