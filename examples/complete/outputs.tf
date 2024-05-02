output "vm_names_minimal" {
  value       = module.minimal.names
  description = "The names of the created vms."
}
output "vm_names_named" {
  value       = module.named.names
  description = "The names of the created vms."
}
output "vm_names_advanced" {
  value       = { for index, pool in module.advanced : index => pool.names }
  description = "The names of the created vms."
}
