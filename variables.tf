variable "rgname" {
    type = string
    description = "used for naming resource group"
    
  
}

variable "rglocation" {
    type = string
    description = "used for selecting the location"
    default = "east US"
}