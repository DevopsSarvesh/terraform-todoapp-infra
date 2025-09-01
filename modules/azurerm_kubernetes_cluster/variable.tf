variable "aks_name" {}
variable "location" {}
variable "rg_name" {}
variable "dns_prefix" {}

variable "vm_size" {
    default = "Standard_A2_v2"   
}

variable "node_count" {
    default = 1
}

variable "tags" {}