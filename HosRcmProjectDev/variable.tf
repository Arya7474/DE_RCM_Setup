variable "rgname" {
  type = string
  default = "HOSRCMDEV"
}
variable "devrgloc" {
  type = string
  default = "eastus"
}
variable "adls" {
  type = string
  default = "hosrcmstorageadls21345"
}
variable "devenv" {
  type = string
  default = "dev"
}
variable "containernames" {
  type = set(string)
  default = [ "landing","bronze","silver","gold" ]
}

variable "claimsdatafiles" {
  type = map(string)
  default = {
    "hospital1_claim_data.csv" = "/Users/scorvicsdomain/Downloads/hospital1_claim_data.csv"
    "hospital2_claim_data.csv"="/Users/scorvicsdomain/Downloads/hospital2_claim_data.csv"
    "cptcodes.csv"="/Users/scorvicsdomain/Downloads/cptcodes.csv"
  }
}

