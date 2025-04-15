variable "subscription_id" {
  description = "Subscription id of the account"
  type = string
  default = "4bcf59ba-7d66-4950-9c1d-8786a2bf6489"
}

variable "location" {
    description = "location of service"
    type = string
    default = "eastus"
}

variable "resource_group_name" {
  description = "resource group name"
  type = string
  default = "rg-aks"
}

variable "acr_name" {
  description = "Name of the service plan"
  type = string
  default = "acrkeshav150425"
}

variable "os" {
  description = "Operating system"
  type = string
  default = "Linux"
}

variable "aks_name" {
    description = "Name of the service plan"
    type = string
    default = "aksDotNetWebapi"
}

variable "dns_prefix"{
  default = "aks-dotnetwebapi"
}