output "vm_names_minimal" {
  value       = module.minimal.vm_names
  description = "The names of the created vms."
}
output "vm_names_named" {
  value       = module.named.vm_names
  description = "The names of the created vms."
}
output "vm_names_advanced" {
  value       = { for index, pool in module.advanced : index => pool.vm_names }
  description = "The names of the created vms."
}
