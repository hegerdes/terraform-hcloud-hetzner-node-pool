# Complete AWS <TODO_EXPANDED> Example

Configuration in this directory creates:

- <XXX>

## Usage

To run this example you need to execute:

```bash
$ terraform init
$ terraform plan
$ terraform apply
```

Note that this example may create resources which will incur monetary charges on your AWS bill. Run `terraform destroy` when you no longer need these resources.

<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.5 |
| <a name="requirement_hcloud"></a> [hcloud](#requirement\_hcloud) | 1.45.0 |
| <a name="requirement_random"></a> [random](#requirement\_random) | 3.5.1 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_hcloud"></a> [hcloud](#provider\_hcloud) | 1.45.0 |

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_advanced"></a> [advanced](#module\_advanced) | ../.. | n/a |
| <a name="module_disabled"></a> [disabled](#module\_disabled) | ../.. | n/a |
| <a name="module_minimal"></a> [minimal](#module\_minimal) | ../.. | n/a |
| <a name="module_named"></a> [named](#module\_named) | ../.. | n/a |

## Resources

| Name | Type |
|------|------|
| [hcloud_network.example](https://registry.terraform.io/providers/hetznercloud/hcloud/1.45.0/docs/resources/network) | resource |
| [hcloud_network_subnet.subnet_1](https://registry.terraform.io/providers/hetznercloud/hcloud/1.45.0/docs/resources/network_subnet) | resource |
| [hcloud_network_subnet.subnet_n](https://registry.terraform.io/providers/hetznercloud/hcloud/1.45.0/docs/resources/network_subnet) | resource |
| [hcloud_ssh_key.example](https://registry.terraform.io/providers/hetznercloud/hcloud/1.45.0/docs/resources/ssh_key) | resource |

## Inputs

No inputs.

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_vm_names_advanced"></a> [vm\_names\_advanced](#output\_vm\_names\_advanced) | The names of the created vms. |
| <a name="output_vm_names_minimal"></a> [vm\_names\_minimal](#output\_vm\_names\_minimal) | The names of the created vms. |
| <a name="output_vm_names_named"></a> [vm\_names\_named](#output\_vm\_names\_named) | The names of the created vms. |
<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->

Apache-2.0 Licensed. See [LICENSE](https://github.com/clowdhaus/terraform-aws-<TODO>/blob/main/LICENSE).
