# variable "vmlinux_web_nsg_ports_inbound" {
#   description = "The list of inbound ports"
#   type        = list(string)
#   default     = [22, 80, 443]
# }

variable "vmlinux_web_size" {
  description = "Web Linux VM Size"
  type = string
  default = "Standard_DS1_v2"
}

variable "vmlinux_web_user" {
  description = "Web Linux VM Admin Username"
  type = string
  default = "rsadmin"
}