variable "vmlinux_web_instance_count" {
  description = "The number of VMs which needs to be deployed"
  type        = number
  default     = 1
}

variable "lb_inbound_nat_ports" {
  description = "The List of Inboud NAT ports"
  type        = list(string)
  default     = ["1022"]
}