# AWS Infrastructure Provisioning Using terraform

Terraform is an open-source infrastructure as code tool that enables you to safely and predictably provision and manage infrastructure in any cloud.

## Prerequisite

* Terraform [link](https://developer.hashicorp.com/terraform/tutorials/aws-get-started/install-cli)

## Steps Involved

Terraform provisions following:

### Security Group

* Security Group to allow ports 443, 8082

### Load Balancer

* Target Group for api which listen to port 8082
* Load balancer for all subnet per availability group
* Fetch certificate for domain
* Default Lb listener for target group
* Custom Lb listener rule for host header `bookmanager.cloudadvocate.net`

### AutoScaling

* Launch template with ami created using packer and with securiy group and load balancer created in previous terraform scripts 
* Autoscaling group with availability zone and desired capacity, maximum size, minimum size
* Autoscaling Atatchment with launch template and AutoScaling group
