# ################# Output #################
output "ips" {
  value       = concat([for srv in hcloud_server.this : srv.ipv4_address], [for srv in hcloud_server.this : srv.ipv6_address])
  description = "List of all public ips of every created server. Includes IPv4 & IPv6."
}
output "names" {
  value       = [for srv in hcloud_server.this : srv.name]
  description = "List of all names for every created server."
}
output "ids" {
  value       = [for srv in hcloud_server.this : srv.id]
  description = "List of all ids for every created server."
}
