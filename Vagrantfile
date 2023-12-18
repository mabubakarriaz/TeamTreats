# -*- mode: ruby -*-
# vi: set ft=ruby :
# https://docs.vagrantup.com.

Vagrant.configure("2") do |config|

  # search boxes at https://vagrantcloud.com/search.
  config.vm.box = "ubuntu/jammy64" 
  config.vm.box_check_update = false # if having issues you can remove this line to auto update to latest box version or run `vagrant box outdated`.

  # virtual machine specific configurations
  config.vm.define "api", primary: true do |api|

    # network settings
    api.vm.hostname = "comet.local" # entry added in /etc/hosts file with private IP
    api.vm.network "private_network", ip: "192.168.200.10", hostname: true
    api.vm.network "forwarded_port", guest: 80, host: 8086, host_ip: "127.0.0.1", protocol: "tcp", auto_correct: true, id: "api_port_rule"
    
    # api code build sync
    api.vm.synced_folder "src/6GT-Companies.API/bin/publish", "/var/www/api", create: true, group: "vagrant", owner: "vagrant", id: "api_mount_folder" # disabled: true # if you want live sync to be turned off
  
    # pre provision script
    api.vm.provision "shell", path: "configs/pre.sh"

    # desired state configuration using ansible local
    api.vm.provision "ansible_local" do |al|
      al.playbook = "configs/playbook.yml"
      al.become = true
      al.become_user = "root"
    end

    # add config files
    api.vm.provision "file", source: "configs/nginx.conf", destination: "/tmp/nginx.conf"
    api.vm.provision "file", source: "configs/api.service", destination: "/tmp/api.service"
    
    # post provision script
    api.vm.provision "shell", path: "configs/post.sh"

  end 

  # VM specs
  config.vm.provider "virtualbox" do |vb|
    vb.memory = "2048"
    vb.cpus = 2
  end

end
