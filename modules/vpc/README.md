# Hyrax VPC
This module installs a VPC with 4 subnets across 3 Availability Zones in a region matching that configured by your terraform `aws` provider.

The VPC's CIDR range is `10.0.0.0/16` and is evenly distributed across 4 subnets to the first three Availability Zone's of the configured region.

| Public | Private | DB | Cache |
| --- | --- | --- | --- |
| `10.0.0.0/24` | `10.0.64.0/24` | `10.0.128.0/24` | `10.0.192.0/24` |
| `10.0.1.0/24` | `10.0.65.0/24` | `10.0.129.0/24` | `10.0.193.0/24` |
| `10.0.2.0/24` | `10.0.66.0/24` | `10.0.130.0/24` | `10.0.194.0/24` |

The Private, Database, & Cache zones can have access to the internet via configuring a single or highly available NAT Gateway.

This module can also be configured to create an S3 endpoint to the VPC as well as a private hosted zone for DNS with private resources.
