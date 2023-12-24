init:
	vagrant destroy
	vagrant box remove alpine-3.19.0
	packer plugins install github.com/hashicorp/virtualbox
	packer plugins install github.com/hashicorp/vagrant
	packer plugins install github.com/hashicorp/ansible

packer:
	packer build -force packer.json

box:
	vagrant box add alpine-3.19.0 .packer/bin/alpine/alpine-3.19.0.box

vagrant:
	vagrant up

clean:
	#rm -rf .vagrant
	#rm -rf .packer
	#vagrant destroy