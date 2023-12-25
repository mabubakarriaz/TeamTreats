# -*- mode: ruby -*-
# vi: set ft=ruby :
# https://docs.vagrantup.com.

# Using environment variables or provide default values
box_name = ENV['VAGRANT_BOX'] || "alpine-3.19.0" # "ubuntu/jammy64"
custom_port = ENV['VAGRANT_PORT'] || 8081

Vagrant.configure("2") do |config|

  # search boxes at https://vagrantcloud.com/search.
  config.vm.box = box_name
  config.vm.box_check_update = false # if having issues you can remove this line to auto update to latest box version or run `vagrant box outdated`.

  # virtual machine specific configurations
  config.vm.define "app", primary: true do |app|

    # network settings
    app.vm.hostname = "TT.local" # entry added in /etc/hosts file with private IP
    app.vm.network "private_network", ip: "192.168.200.10", hostname: true
    app.vm.network "forwarded_port", guest: 80, host: custom_port, host_ip: "127.0.0.1", protocol: "tcp", auto_correct: true, id: "app_port_rule"
    
    # app code build sync
    app.vm.synced_folder "src/teamtreats-webapp/bin/publish", "/var/www/app", create: true, group: "vagrant", owner: "vagrant", id: "app_mount_folder" # disabled: true # if you want live sync to be turned off
  
    # pre provision script
    app.vm.provision "shell", path: "configs/vagrant/pre.sh"

    # desired state configuration using ansible local
    # app.vm.provision "ansible_local" do |al|
    #   al.playbook = "configs/vagrant/playbook.yml"
    #   al.become = true
    #   al.become_user = "root"
    # end

    # add config files
    app.vm.provision "file", source: "configs/vagrant/nginx.conf", destination: "/tmp/nginx.conf"
    app.vm.provision "file", source: "configs/vagrant/teamtreats", destination: "/tmp/teamtreats"
    
    # post provision script
    app.vm.provision "shell", path: "configs/vagrant/post.sh"

  end 

  # VM specs
  config.vm.provider "virtualbox" do |vb|
    vb.memory = "2048"
    vb.cpus = 2
  end

end
