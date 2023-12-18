resource "random_string" "myrandom" {
  length  = 5
  upper   = false
  special = false
  numeric = false
  lower   = true
}