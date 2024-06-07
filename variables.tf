variable "name" {
  type        = string
  description = "Node name prefix."
  validation {
    condition     = length(var.name) >= 3
    error_message = "Name must be at least 3 characters long."
  }
}

variable "size" {
  type        = number
  description = "Number of nodes to create. Will only be used if vm_names is empty."
  default     = 1
  validation {
    condition     = var.size >= 0
    error_message = "Size must be a positive number."
  }
}

variable "vm_names" {
  type        = list(string)
  description = "List of names for the VMs. to create"
  default     = []
}

variable "image" {
  type        = string
  description = "Node image name."
  default     = "debian-12"
}

variable "location" {
  type        = string
  description = "Node location."
  validation {
    condition     = contains(["fsn1", "nbg1", "hel1", "ash", "hil"], lower(var.location))
    error_message = "Unsupported location type."
  }
}

variable "instance_type" {
  type        = string
  description = "Node instance type."
  default     = "cx11"
  validation {
    condition     = contains(["cx11", "cx21", "cx22", "cx31", "cx32", "cx41", "cx42", "cx51", "cx52", "cpx11", "cpx21", "cpx31", "cpx41", "cpx51", "ccx12", "ccx22", "ccx32", "ccx42", "ccx52", "ccx62", "ccx13", "ccx23", "ccx33", "ccx43", "ccx53", "ccx63", "cax11", "cax21", "cax31", "cax41"], lower(var.instance_type))
    error_message = "Unsupported server type."
  }
}

variable "ssh_keys" {
  type        = list(string)
  description = "Nodes public ssh keys ids or names or the key itself. If its the key you have to set create_ssh_keys."
  default     = []
}

variable "create_ssh_keys" {
  type        = bool
  description = "Hetzner allows create a ssh key only once. By default you have to create them before. If you set this flag the module will create them."
  default     = false
}

variable "tags" {
  type        = any
  description = "Node tags/labels"
  default     = {}
}

variable "backups" {
  type        = bool
  description = "Backups enabled"
  default     = false
}

variable "fixed_disk_size" {
  type        = bool
  description = "Whether the disk size should also be upgraded when scaling up. If true, downgrades may not be possible anymore."
  default     = false
}

variable "user_data" {
  type        = string
  description = "Node user data (cloud-init)"
  default     = null
}

variable "public_ipv4" {
  type        = bool
  description = "Node public ipv4 ip"
  default     = true
}

variable "public_ipv6" {
  type        = bool
  description = "Node public ipv6 ip"
  default     = true
}

variable "network_name" {
  type        = string
  description = "Node network name"
  default     = null
}

variable "private_ip_addresses" {
  type        = list(string)
  description = "Node private ips. Network name must be set for this."
  default     = []
}

variable "snapshot_image" {
  type        = bool
  description = "Node image is snapshot"
  default     = false
}

variable "firewall_ids" {
  type        = list(string)
  description = "Ids of firewall attacted to the server"
  default     = null
}
