# ################# Output #################
output "name" {
  value       = var.name
  description = "The name of the node pool."
}
output "vms" {
  value       = { for srv in hcloud_server.this : srv.name => srv }
  description = "Object of vm data based on name."
}
output "vms_raw" {
  value       = hcloud_server.this
  description = "Raw object of hcloud server objects."
}
output "vm_names" {
  value       = [for srv in hcloud_server.this : srv.name]
  description = "List of all names for every created server."
}
output "vm_ids" {
  value       = [for srv in hcloud_server.this : srv.id]
  description = "List of all ids for every created server."
}
output "vm_ips" {
  value       = concat([for srv in hcloud_server.this : srv.ipv4_address if srv.ipv4_address != ""], [for srv in hcloud_server.this : srv.ipv6_address if srv.ipv6_address != ""])
  description = "List of all public ips of every created server. Includes IPv4 & IPv6."
}
output "vm_volumes" {
  value       = [for vol in hcloud_volume.this : vol.name]
  description = "List of all additional disks for every created server."
}
