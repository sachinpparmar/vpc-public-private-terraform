variable "cidr" {
  type = string
  default = "192.168.0.0/16"
}

variable "enable_dns_hostnames" {
 type = bool
 default = null

}
variable "enable_dns_support" {
 type = bool
 default = null 
}
variable "public-subnet-1-cidr" {
 type = string
 default = "192.168.1.0/24"
}
variable "map_public_ip_on_launch" {
 type = bool
 default = null 
}

variable "public-subnet-2-cidr" {
 type = string
 default = "192.168.2.0/24"
}
variable "private-subnet-1-cidr" {
 type = string
 default = "192.168.5.0/24"
}

variable "private-subnet-2-cidr" {
 type = string
 default = "192.168.6.0/24"
}

variable "public-route-table" {
  description = "Tag name for public route table"
  type        = string
  default     = "public-route-table"
}

variable "private-route-table" {
  description = "Tag name for public route table"
  type        = string
  default     = "private-route-table"
}
