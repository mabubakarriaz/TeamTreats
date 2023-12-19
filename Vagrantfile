# -*- mode: ruby -*-
# vi: set ft=ruby :
# https://docs.vagrantup.com.

Vagrant.configure("2") do |config|

  # search boxes at https://vagrantcloud.com/search.
  config.vm.box = "ubuntu/jammy64" 
  config.vm.box_check_update = false # if having issues you can remove this line to auto update to latest box version or run `vagrant box outdated`.

  # virtual machine specific configurations
  config.vm.define "app", primary: true do |app|

    # network settings
    app.vm.hostname = "comet.local" # entry added in /etc/hosts file with private IP
    app.vm.network "private_network", ip: "192.168.200.10", hostname: true
    app.vm.network "forwarded_port", guest: 80, host: 8081, host_ip: "127.0.0.1", protocol: "tcp", auto_correct: true, id: "app_port_rule"
    
    # app code build sync
    app.vm.synced_folder "src/teamtreats-webapp/bin/publish", "/var/www/app", create: true, group: "vagrant", owner: "vagrant", id: "app_mount_folder" # disabled: true # if you want live sync to be turned off
  
    # pre provision script
    app.vm.provision "shell", path: "configs/pre.sh"

    # desired state configuration using ansible local
    app.vm.provision "ansible_local" do |al|
      al.playbook = "configs/playbook.yml"
      al.become = true
      al.become_user = "root"
    end

    # add config files
    app.vm.provision "file", source: "configs/nginx.conf", destination: "/tmp/nginx.conf"
    app.vm.provision "file", source: "configs/app.service", destination: "/tmp/app.service"
    
    # post provision script
    app.vm.provision "shell", path: "configs/post.sh"

  end 

  # VM specs
  config.vm.provider "virtualbox" do |vb|
    vb.memory = "2048"
    vb.cpus = 2
  end

end
