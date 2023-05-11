packer {
  required_plugins {
    amazon = {
      version = ">= 1.2.2"
      source = "github.com/hashicorp/amazon"
    }
  }
}


source "amazon-ebs" "bookmanager" {
  region = "ap-south-1"
  source_ami = "ami-02eb7a4783e7e9317"
  instance_type = "t2.micro"
  ssh_username = "ubuntu"
  skip_region_validation = true
}

build {
  source "sources.amazon-ebs.bookmanager" {
    ami_name = "bookmanager-{{timestamp}}"
  }
  provisioner "file" {
    source = "bookmanager.jar"
    destination = "/tmp/bookmanager.jar"
  }

  provisioner "file" {
    source = "./module6/iac/packer/bookmanager.service"
    destination = "/tmp/bookmanager.service"
  }

  provisioner "shell" {
    script = "./module6/iac/packer/install_ansible.sh"
  }
  provisioner "ansible-local" {
      playbook_file = "./module6/iac/packer/playbook.yaml"
  }
}


