# Terraform module VPC Core Multi-AZ:

Terraform module to manage VPC service that supports Multi availability Zone and easy infrastructure scaling.

## Application example:

Declaration of the module:

```hcl-terraform
module "core" {
  source = "git::https://example.com/vpc.git?ref=v1.2.0"

  environment = "${var.environment}"

  managed_by = "${var.managed_by}"

  zones = [
    "${var.aws_zones}"
  ]
}
```

Examples of variable values:

```hcl-terraform
aws_zones = [
  "us-east-1a",
  "us-east-1b",
]

environment = "Shop"

managed_by = "TeamName | Terraform"
```

## Available variables:

 * `vpc_cidr` - A network for VPC.
 * `networks_space` - Maximum number of DMZ networks and the number of networks preceding the Resource networks.
 * `zones` - List of available zones.
 * `environment` - Environment name.
 * `managed_by` - The name of the resource management unit and tools eg. 'TeamName | Terraform'.
 * `network_size` - Number of bits per network.

## The most important functionalities:

### Very easy scale to new available zones:

If you want to scan the infrastructure for the next zone availability, you should add name availability zones to list.

This will create resources in the new availability zone, without deleting the current resources.

```hcl-terraform
aws_zones = [
  "us-east-1a",
  "us-east-1b",
  "us-east-1c",
]
```

### Separation of IP addresses for public and private networks:

The `networks space` variable specifies the space for public networks 
and variable shifts the IP addresses for private networks (default value: 10).

For example:

   * The **first** Accessibility Zone:
      * Public network: 172.30.0.0/24
      * Private network: 172.30.10.0/24

   * The **second** Accessibility Zone:
     * Public network: 172.30.1.0/24
     * Private network: 172.30.11.0/24

   * The **third** Accessibility Zone:
     * Public network: 172.30.2.0/24
     * Private network: 172.30.12.0/24
     
   * ...