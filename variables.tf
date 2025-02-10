variable "resource_group_name" {
  description = "Name of the Azure Resource Group"
  type        = string
  default     = "my-terraform-rg"
}

variable "location" {
  description = "Azure region (e.g., Canada Central)"
  type        = string
  default     = "Canada Central"
}

variable "subscription_id" {
  description = "The Azure Subscription ID"
  type        = string
}

variable "client_id" {
  description = "The Azure Client ID"
  type        = string
}

variable "client_secret" {
  description = "The Azure Client Secret"
  type        = string
}

variable "tenant_id" {
  description = "The Azure Tenant ID"
  type        = string
}
