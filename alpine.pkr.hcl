packer {
  required_plugins {
    virtualbox = {
      version = "~> 1"
      source  = "github.com/hashicorp/virtualbox"
    }
    vagrant = {
      version = "~> 1"
      source = "github.com/hashicorp/vagrant"
    }
    ansible = {
      version = "~> 1"
      source = "github.com/hashicorp/ansible"
    }
  }
}

# --------------------------------------------------
# Packer Variables
# --------------------------------------------------
variable "name" {
  type    = string
  default = "alpine"
}

variable "version" {
  type    = string
  default = "3.21.0"
}

variable "out_dir" {
  type    = string
  default = ".packer/bin/alpine"
}

variable "cpus" {
  type    = string
  default = "1"
}

variable "disk_size" {
  type    = string
  default = "2048"
}

variable "memory" {
  type    = string
  default = "512"
}

variable "iso_file" {
  type    = string
  default = "https://nl.alpinelinux.org/alpine/v3.21/releases/x86_64/alpine-virt-3.21.0-x86_64.iso"
}

variable "iso_checksum" {
  type    = string
  default = "adf9ecc5b8ec865721dd875222b9b55f250ed594c69ebf1326451595878ce051"
}

variable "ssh_password" {
  type    = string
  default = "alpine"
}

variable "ssh_wait_timeout" {
  type    = string
  default = "90s"
}

# --------------------------------------------------
# Packer Source (Builder)
# --------------------------------------------------
source "virtualbox-iso" "alpine" {
  vm_name               = "${var.name}-${var.version}"
  guest_additions_mode  = "disable"
  guest_os_type         = "Linux26_64"
  http_directory        = "configs"
  http_port_min         = 8500
  http_port_max         = 9000
  http_bind_address     = "0.0.0.0"
  output_directory      = var.out_dir
  shutdown_command      = "poweroff"
  boot_wait             = "20s"
  communicator          = "ssh"
  ssh_username          = "root"
  ssh_password          = var.ssh_password
  ssh_timeout           = var.ssh_wait_timeout
  disk_size             = var.disk_size
  hard_drive_interface  = "sata"
  cpus                  = var.cpus
  memory                = var.memory
  headless              = false

  # ISO Settings
  iso_url          = var.iso_file
  iso_checksum     = "sha256:${var.iso_checksum}"

  # Boot Commands
  boot_command = [
    "root<enter><wait>",
    "ifconfig eth0 up && udhcpc -i eth0<enter><wait5>",
    "setup-keymap us us<enter><wait>",
    "setup-hostname alpine<enter><wait>",
    "setup-interfaces -a<enter><wait>",
    "setup-ntp openntpd<enter><wait>",
    "setup-apkrepos -r<enter><wait>",
    "setup-sshd openssh<enter><wait>",
    "echo PermitRootLogin yes >> /etc/ssh/sshd_config<enter>",
    "service sshd restart<enter>",
    "echo 'root:${var.ssh_password}' | chpasswd<enter>",
    "setup-disk -m sys /dev/sda<enter><wait>",
    "<wait5><wait5><wait5>",
    "<wait5><wait5><wait5>",
    "y<enter><wait>",
    "<wait10><wait10><wait10>",
    "<wait10><wait10><wait10>",
    "<wait10><wait10><wait10>",
    "<wait10><wait10><wait10>",
    "<wait10><wait10><wait10>",
    "<wait10><wait10><wait10>",
    "service sshd stop<enter><wait>",
    "mount /dev/sda3 /mnt<enter><wait>",
    "echo 'PermitRootLogin yes' >> /mnt/etc/ssh/sshd_config<enter><wait>",
    "echo 'UseDNS no' >> /mnt/etc/ssh/sshd_config<enter><wait>",
    "umount /mnt<enter><wait>",
    "reboot<enter>"
  ]

  # VirtualBox-Specific Options
  vboxmanage = [
    ["modifyvm", "{{.Name}}", "--macaddress1", "aa33dd44bbdd"],
    ["modifyvm", "{{.Name}}", "--nat-localhostreachable1", "on"]
  ]
}

# --------------------------------------------------
# Packer Build with Provisioners and Post-Processors
# --------------------------------------------------
build {
  name    = "alpine"
  sources = ["source.virtualbox-iso.alpine"]

  provisioner "shell" {
    execute_command = "/bin/sh -x '{{.Path}}'"
    script          = "configs/packer/pre.sh"
  }

  provisioner "ansible-local" {
    playbook_file = "configs/packer/playbook.yml"
  }

  provisioner "file" {
    source      = "configs/packer/motd"
    destination = "/tmp/motd"
  }

  provisioner "shell" {
    execute_command = "/bin/sh -x '{{.Path}}'"
    script          = "configs/packer/post.sh"
  }

  post-processor "vagrant" {
    output              = "${var.out_dir}/${var.name}-${var.version}.box"
    provider_override   = "virtualbox"
    architecture        = "amd64"
    compression_level   = 9
    keep_input_artifact = true
  }
}
