variable "project_id" {
  description = "GCP project ID"
  type        = string
}

variable "region" {
  default     = "us-central1"
}

variable "zone" {
  default     = "us-central1-a"
}

variable "cluster_name" {
  default     = "dashboard-cluster"
}

variable "node_count" {
  default     = 2
}

variable "machine_type" {
  default     = "e2-medium"
}

variable "image" {
  description = "Docker image for dashboard"
  type        = string
}
