packer:
	packer build packer.json

box:
	vagrant box add alpine-3.19.0 .packer/bin/alpine/alpine-3.19.0.box

vagrant:
	vagrant up

clean:
	#rm -rf output-virtualbox-iso
	#rm -rf out
	#vagrant destroy