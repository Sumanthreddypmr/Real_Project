variable "cluster_name" {
  default = "sumanth_cluster"
}

variable "create_irsa" {
  default = false
}

# Only needed if using IRSA (false in your case)
variable "oidc_url" {
  default = ""
}

variable "oidc_thumbprint" {
  default = ""
}

variable "service_account" {
  default = ""
}
