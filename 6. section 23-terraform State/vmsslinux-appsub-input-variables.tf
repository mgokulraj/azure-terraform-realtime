variable "vmsslinux_app_nsg_ports_inbound" {
  description = "The list of inbound ports"
  type        = list(string)
  default     = [22, 80, 443]
}

