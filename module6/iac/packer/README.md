
# AWS AMI Building Using Packer 

Packer is used to create AMI

Packer is a free and open source tool for creating golden images for multiple platforms from a single source configuration.


## Prerequisite

* Packer [link](https://developer.hashicorp.com/packer/tutorials/docker-get-started/get-started-install-cli)

## Steps Involved

* AWS EC2 instance is created using provided ami source and instance type
* SSH into EC2 instance created using ssh_username provided and execute build steps
* Copy jar file from current directory 
* Copy service file from for book manager application from current directory
* Execute install ansible script which install ansible to bootstrap the application
* Execute ansible playbook. Following are tasks performed by playbook
  * Install Java 
  * Create log directories and files for bookmanager service
  * Place bookmanager service inside systemd standard directory path
  * Enable bookmanager service
  * Staert bookmanager application

## Execution

```
export AWS_ACCESS_KEY_ID=<AWS_ACCESS_KEY_ID>
export AWS_SECRET_ACCESS_KEY=<AWS_SECRET_ACCESS_KEY>
export AWS_DEFAULT_REGION=<AWS_DEFAULT_REGION>
packer init book-manager.pkr.hcl
packer build book-manager.pkr.hcl
```