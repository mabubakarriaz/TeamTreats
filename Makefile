build:
	packer build alpine-iso-install.json

add-box:
	vagrant box add alpine-clean-3.6.1 out/alpine-clean-3.6.1.box

run-vagrant:
	cd apline-vagrant
	vagrant init alpine-clean-3.6.1

clean:
	rm -rf output-virtualbox-iso
	#rm -rf out
	#vagrant destroy