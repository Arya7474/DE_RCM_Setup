variable "sourcergname" {
  type = string
  default = "HOSRCMSOURCE"
}

variable "sourcergloc" {
  type = string
  default = "eastus"
}

variable "env" {
  type = string
  default = "source"
}

variable "serverloc" {
  type = string
  default = "West US 2"

}
variable "servercred" {
  type = list(string)
  default = [ "admin4dm1n157r470r","4-v3ry-53cr37-p455w0rd" ]
  sensitive = true
}
variable "databasenames" {
  type = set(string)
  default = [ "trendytech-hospital-a","trendytech-hospital-b" ]
}

variable "myip" {
  type = string
  sensitive = true
}

variable "adfname" {
  type = string
  default = "HOSRCMSOURCEADF4321"
}

variable "sourceuserassignedmid" {
  type = string
  default = "sourceuserassignedmid221"
}


# az ad sp show --id <ADF_MANAGED_IDENTITY_CLIENT_ID> --query objectId --output tsv
