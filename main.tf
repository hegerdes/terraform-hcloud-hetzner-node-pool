# Shared and calculated vars
locals {
  # Names of vm and vm objects
  user_names = length(var.vm_names) > 0
  vms        = local.user_names ? var.vm_names : [for i in range(var.size) : tostring(i)]
  ssh_keys   = var.create_ssh_keys ? [for key in hcloud_ssh_key.this : key.name] : var.ssh_keys

  # Image and Arch setup
  image       = local.is_snapshot ? data.hcloud_image.this[0].id : var.image
  is_snapshot = var.snapshot_image || strcontains(var.image, "snapshot")
  is_arm      = contains(["cax11", "cax21", "cax31", "cax41"], lower(var.instance_type))
  arch        = local.is_arm ? "arm64" : "amd64"

  # Tags
  tags = merge(local.default_tags, var.tags)
  default_tags = {
    managedby = "terraform"
  }
}

# Get image if snapshot is used
data "hcloud_image" "this" {
  count             = local.is_snapshot ? 1 : 0
  with_architecture = local.is_arm ? "arm" : "x86"
  with_selector     = "name=${var.image}"
}

# Get network if used
data "hcloud_network" "this" {
  count = var.network_name != null ? 1 : 0
  name  = var.network_name
}

# Create placement group
resource "hcloud_placement_group" "this" {
  name   = var.name
  type   = "spread"
  labels = local.tags
}

# Create random name postfix if no names supplied
resource "random_string" "this" {
  count   = local.user_names ? 0 : var.size
  length  = 6
  special = false
  lower   = true
  upper   = false
}

# Create ssh keys if create_ssh_keys is set
resource "hcloud_ssh_key" "this" {
  for_each   = var.create_ssh_keys ? toset(var.ssh_keys) : toset([])
  name       = sha256(each.key)
  public_key = each.key
  lifecycle {
    create_before_destroy = false
  }
}

# Create servers
resource "hcloud_server" "this" {
  for_each           = { for index, vm in local.vms : vm => index }
  name               = "${var.name}-${local.user_names ? each.key : random_string.this[each.key].result}"
  image              = local.image
  server_type        = var.instance_type
  location           = var.location
  user_data          = var.user_data
  backups            = var.backups
  keep_disk          = var.fixed_disk_size
  firewall_ids       = var.firewall_ids
  labels             = merge(local.tags, { sku = var.instance_type, arch = local.arch })
  ssh_keys           = local.ssh_keys
  placement_group_id = hcloud_placement_group.this.id

  public_net {
    ipv4_enabled = var.public_ipv4
    ipv6_enabled = var.public_ipv6
  }

  dynamic "network" {
    for_each = var.network_name != null ? [1] : []
    content {
      network_id = data.hcloud_network.this[0].id
      ip         = length(var.private_ip_addresses) > 0 ? var.private_ip_addresses[each.value] : null
      alias_ips  = length(local.vms) == 1 ? try(slice(var.private_ip_addresses, 1, length(var.private_ip_addresses) - 1), null) : null
    }
  }

  lifecycle {
    create_before_destroy = false
    ignore_changes = [
      ssh_keys,
      user_data,
    ]
  }
}
