packer:
	packer build alpine-iso-install.json

box:
	vagrant box add alpine-clean-3.6.1 out/alpine-clean-3.6.1.box

vagrant:
	cd apline-vagrant
	vagrant init alpine-clean-3.6.1
	vagrant up

clean:
	rm -rf output-virtualbox-iso
	#rm -rf out
	#vagrant destroy