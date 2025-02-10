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