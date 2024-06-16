# terraform-hcloud-hetzner-node-pool terraform module

Terraform module which creates terraform-hcloud-hetzner-node-pool resources. The module can be found on the [terraform.io registry](https://registry.terraform.io/modules/hegerdes/hetzner-node-pool/hcloud/latest) or on [github](https://github.com/hegerdes/terraform-hcloud-hetzner-node-pool).

## Usage

See [`examples`](https://github.com/hegerdes/terraform-hcloud-hetzner-node-pool/tree/main/examples) directory for working examples to reference:

```hcl
module "hetzner_node_pool" {
  source = "hegerdes/terraform-hcloud-hetzner-node-pool/"

  size     = 1
  name     = "example"
  location = "fsn1"
  tags     = {cloud = "true"}
}
```
*NOTE:* Due to an [issue](https://github.com/hetznercloud/terraform-provider-hcloud/issues/911) in the hetzner terraform provider, it is currently not possible to set firewall ids via labels and via the `firewall_ids` input. Users have to decide for one of these methods.

## Examples

Examples codified under the [`examples`](https://github.com/hegerdes/terraform-hcloud-hetzner-node-pool/tree/main/examples) are intended to give users references for how to use the module(s) as well as testing/validating changes to the source code of the module. If contributing to the project, please be sure to make any appropriate updates to the relevant examples to allow maintainers to test your changes and to keep the examples up to date for users. Thank you!

- [Complete](https://github.com/hegerdes/terraform-hcloud-hetzner-node-pool/tree/main/examples/complete)

<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.5 |
| <a name="requirement_hcloud"></a> [hcloud](#requirement\_hcloud) | >=1.40 |
| <a name="requirement_random"></a> [random](#requirement\_random) | >=3.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_hcloud"></a> [hcloud](#provider\_hcloud) | >=1.40 |
| <a name="provider_random"></a> [random](#provider\_random) | >=3.0 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [hcloud_placement_group.this](https://registry.terraform.io/providers/hetznercloud/hcloud/latest/docs/resources/placement_group) | resource |
| [hcloud_server.this](https://registry.terraform.io/providers/hetznercloud/hcloud/latest/docs/resources/server) | resource |
| [hcloud_ssh_key.this](https://registry.terraform.io/providers/hetznercloud/hcloud/latest/docs/resources/ssh_key) | resource |
| [random_string.this](https://registry.terraform.io/providers/hashicorp/random/latest/docs/resources/string) | resource |
| [hcloud_image.this](https://registry.terraform.io/providers/hetznercloud/hcloud/latest/docs/data-sources/image) | data source |
| [hcloud_network.this](https://registry.terraform.io/providers/hetznercloud/hcloud/latest/docs/data-sources/network) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_backups"></a> [backups](#input\_backups) | Backups enabled | `bool` | `false` | no |
| <a name="input_create_ssh_keys"></a> [create\_ssh\_keys](#input\_create\_ssh\_keys) | Hetzner allows create a ssh key only once. By default you have to create them before. If you set this flag the module will create them. | `bool` | `false` | no |
| <a name="input_firewall_ids"></a> [firewall\_ids](#input\_firewall\_ids) | Ids of firewall attacted to the server | `list(string)` | `null` | no |
| <a name="input_fixed_disk_size"></a> [fixed\_disk\_size](#input\_fixed\_disk\_size) | Whether the disk size should also be upgraded when scaling up. If true, downgrades may not be possible anymore. | `bool` | `false` | no |
| <a name="input_image"></a> [image](#input\_image) | Node image name. | `string` | `"debian-12"` | no |
| <a name="input_instance_type"></a> [instance\_type](#input\_instance\_type) | Node instance type. | `string` | `"cx22"` | no |
| <a name="input_location"></a> [location](#input\_location) | Node location. | `string` | n/a | yes |
| <a name="input_name"></a> [name](#input\_name) | Node name prefix. | `string` | n/a | yes |
| <a name="input_network_name"></a> [network\_name](#input\_network\_name) | Node network name | `string` | `null` | no |
| <a name="input_private_ip_addresses"></a> [private\_ip\_addresses](#input\_private\_ip\_addresses) | Node private ips. Network name must be set for this. | `list(string)` | `[]` | no |
| <a name="input_public_ipv4"></a> [public\_ipv4](#input\_public\_ipv4) | Node public ipv4 ip | `bool` | `true` | no |
| <a name="input_public_ipv6"></a> [public\_ipv6](#input\_public\_ipv6) | Node public ipv6 ip | `bool` | `true` | no |
| <a name="input_size"></a> [size](#input\_size) | Number of nodes to create. Will only be used if vm\_names is empty. | `number` | `1` | no |
| <a name="input_snapshot_image"></a> [snapshot\_image](#input\_snapshot\_image) | Node image is snapshot | `bool` | `false` | no |
| <a name="input_ssh_keys"></a> [ssh\_keys](#input\_ssh\_keys) | Nodes public ssh keys ids or names or the key itself. If its the key you have to set create\_ssh\_keys. | `list(string)` | `[]` | no |
| <a name="input_tags"></a> [tags](#input\_tags) | Node tags/labels | `any` | `{}` | no |
| <a name="input_user_data"></a> [user\_data](#input\_user\_data) | Node user data (cloud-init) | `string` | `null` | no |
| <a name="input_vm_names"></a> [vm\_names](#input\_vm\_names) | List of names for the VMs. to create | `list(string)` | `[]` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_ids"></a> [ids](#output\_ids) | List of all ids for every created server. |
| <a name="output_ips"></a> [ips](#output\_ips) | List of all public ips of every created server. Includes IPv4 & IPv6. |
| <a name="output_names"></a> [names](#output\_names) | List of all names for every created server. |
<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->

## License

Apache-2.0 Licensed. See [LICENSE](https://github.com/hegerdes/terraform-hcloud-hetzner-node-poolblob/main/LICENSE).
