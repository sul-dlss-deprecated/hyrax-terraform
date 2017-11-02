## Hyrax Zookeeper module

This module provides the following AWS resources:
  - A single container Docker Elastic Beanstalk load balanced environment
  - Needed security groups for internal communications and provides two variables (`lb_security_groups` & `instance_security_groups`) for configuring access to either load balancer or the instances
  - A S3 bucket to share zookeeper configuration between instances (bucket name configured via `shared_configs_bucket_name`)
  - A DNS record for the load balancer at a configurable Hosted Zone (via `hosted_zone_name`)
  - An IAM role for lambda execute permissions
  - A CloudWatch event rule listening for `EC2 Instance Launch Successful` & `EC2 Instance Terminate Successful` events in ZooKeeper's auto scaling group. Those events kicks off the upsert.js lambda script to update a zk-ips DNS record for current zookeeper IPs.
  - A custom cloudformation stack to initialize the upsert lambda script
