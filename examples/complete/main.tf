locals {
  name            = "hcloud-node-pool-${basename(path.cwd)}"
  location        = "fsn1"
  network_name    = "demo-net"
  ssh_key_paths   = ["~/.ssh/id_rsa.pub", "data/cloud-test.pub"]
  ssh_keys        = [for key in local.ssh_key_paths : file(key) if fileexists(key)]
  cloud_init_path = "data/cloud-init-default.yml"
  tags = {
    name    = local.name
    example = local.name
    # repository = "https://github.com/hegerdes/terraform-hcloud-node-pool"
  }
}

################################################################################
# hcloud-node-pool Module
################################################################################

module "disabled" {
  source = "../.."

  size     = 0
  name     = "disabled"
  location = local.location
}

module "minimal" {
  source = "../.."

  size     = 1
  name     = "minimal"
  location = local.location
  tags     = local.tags
}

module "named" {
  source = "../.."

  size                     = 3
  name                     = "named"
  image                    = "ubuntu-22.04"
  vm_names                 = ["vm1", "vm2", "vm3"]
  location                 = local.location
  instance_type            = "cax11"
  public_ipv4              = false
  ssh_keys                 = [for key in hcloud_ssh_key.example : key.name]
  network_name             = local.network_name
  volumes                  = [{ name = "data", size = 10 }]
  shutdown_before_deletion = true
  # Only works if ssh keys below are not created
  # create_ssh_keys = true

  # Last vm will auto assign a pvt ip
  private_ip_addresses = ["10.0.0.5", "10.0.0.6", "10.0.0.7"]
  tags                 = local.tags

  depends_on = [hcloud_network.example]

}

module "advanced" {
  source   = "../.."
  for_each = local.node_pools

  name          = each.value.name
  size          = each.value.size
  image         = each.value.image
  location      = each.value.location
  instance_type = each.value.instance
  ssh_keys      = each.value.ssh_keys

  tags                 = each.value.tags
  volumes              = each.value.volumes
  user_data            = each.value.user_data
  network_name         = each.value.network_name
  private_ip_addresses = each.value.private_ip_addresses

  depends_on = [hcloud_network.example]
}

# Multiple node_pools
locals {
  node_pool_config = [
    {
      name     = "controlplane-node-amd64"
      size     = 1
      instance = "cx11"
      image    = "debian-12"
      volumes  = [{ name = "vol1", size = 10 }, { name = "vol2", size = 15 }]
      tags = {
        k8s = "control-plane"
      }
    },
    {
      name     = "worker-node-amd64"
      size     = 1
      instance = "cx22"
      image    = "debian-12"
      tags = {
        k8s = "worker"
      }
      }, {
      name     = "worker-node-arm64"
      size     = 1
      instance = "cax11"
      image    = "debian-12"
      tags = {
        k8s = "worker"
      }
    }
  ]

  node_pools = { for index, pool in local.node_pool_config :
    pool.name => merge(
      pool, {
        user_data = templatefile(local.cloud_init_path, {
          ssh_key = [for key in local.ssh_keys : key]
        })
        tags                 = merge(pool.tags, local.tags)
        ssh_keys             = [for key in hcloud_ssh_key.example : key.name]
        network_name         = hcloud_network.example.name
        location             = local.location
        volumes              = try(pool.volumes, [])
        private_ip_addresses = try([for i in range(pool.size) : cidrhost("10.0.${index + 1}.0/24", i + 8)], [])
      }
    )
  }
}

################################################################################
# helper
################################################################################

resource "hcloud_network" "example" {
  name     = local.network_name
  ip_range = "10.0.0.0/16"
}

resource "hcloud_network_subnet" "subnet_1" {
  type         = "cloud"
  network_id   = hcloud_network.example.id
  network_zone = "eu-central"
  ip_range     = "10.0.0.0/24"
}

resource "hcloud_ssh_key" "example" {
  for_each   = toset(local.ssh_keys)
  name       = sha256(each.key)
  public_key = each.key
  lifecycle {
    create_before_destroy = false
  }
}

resource "hcloud_network_subnet" "subnet_n" {
  type         = "cloud"
  network_id   = hcloud_network.example.id
  network_zone = "eu-central"
  ip_range     = "10.0.${count.index + 1}.0/24"
  count        = length(local.node_pools)
  lifecycle {
    create_before_destroy = false
  }
}
