init:
	packer plugins install github.com/hashicorp/virtualbox
	packer plugins install github.com/hashicorp/vagrant
	packer plugins install github.com/hashicorp/ansible

packer:
	packer build -force packer.json
	
vagrant:
	vagrant box add alpine-3.19.0 .packer/bin/alpine/alpine-3.19.0.box
	vagrant up

clean:
	vagrant destroy -f
	vagrant box remove alpine-3.19.0