# -*- mode: ruby -*-
# vi: set ft=ruby :

VM_MEMORY = "512"
VM_VERSION = "ubuntu/xenial64"
VM_PROVIDER = "virtualbox"

$script = <<-SCRIPT
echo Server provisioning commencing...
ROOT_DIR = $PWD
ansible-playbook -i $ROOT_DIR/ansible/hosts $ROOT_DIR/ansible/main.yml -e 'ansible_python_interpreter=/usr/bin/python'
SCRIPT

# All Vagrant configuration is done below. The "2" in Vagrant.configure
# configures the configuration version (we support older styles for
# backwards compatibility). Please don't change it unless you know what
# you're doing.
Vagrant.configure("2") do |config|
  # The most common configuration options are documented and commented below.
  # For a complete reference, please see the online documentation at
  # https://docs.vagrantup.com.

  # Every Vagrant development environment requires a box. You can search for
  # boxes at https://vagrantcloud.com/search.
  
    config.vm.define "mysql1" do |mysql1|
      mysql1.vm.box = VM_VERSION
      mysql1.vm.hostname = "mysql1.local"
      mysql1.vm.network "private_network", ip: "172.28.128.3", nic_type: "virtio"
      mysql1.vm.network "forwarded_port", guest: 3306, host: 3306
      mysql1.vm.provider VM_PROVIDER do |vb|
        vb.memory = VM_MEMORY
        #vb.gui = true
        #vb.default_nic_type = "82543GC"
        
      end

      mysql1.vm.provision "shell", inline: <<-SHELL
          echo Pre-installing the Python 2.7 requirement on MYSQL1...
          echo "y" | sudo apt install python
          python --version
      SHELL
    
      #
      # Run Ansible from the Vagrant Host
      #

      mysql1.vm.provision "ansible" do |ansible|
        ansible.playbook = "ansible/main.yml"
        ansible.limit = "all"
        ansible.verbose = "v"
      end

    end
  
    config.vm.define "backup1" do |backup1|
      backup1.vm.box = VM_VERSION
      backup1.vm.hostname = "backup1.local"
      backup1.vm.network "private_network", ip: "172.28.128.4", nic_type: "virtio"
      backup1.vm.network "forwarded_port", guest: 3306, host: 3307
      backup1.vm.provider VM_PROVIDER do |vb|
        vb.memory = VM_MEMORY
        #vb.gui = true
        #vb.default_nic_type = "82543GC"
        
      end
      
      backup1.vm.provision "shell", inline: <<-SHELL
        echo Pre-installing the Python 2.7 requirement on BACKUP1...
        echo "y" | sudo apt install python
        python --version
      SHELL

      #
      # Run Ansible from the Vagrant Host
      #
      backup1.vm.provision "ansible" do |ansible|
        ansible.playbook = "ansible/main.yml"
        ansible.limit = "all"
        ansible.verbose = "v"
      end 

    end
  
  
  config.vm.box = VM_VERSION

  # Disable automatic box update checking. If you disable this, then
  # boxes will only be checked for updates when the user runs
  # `vagrant box outdated`. This is not recommended.
  # config.vm.box_check_update = false

  # Create a forwarded port mapping which allows access to a specific port
  # within the machine from a port on the host machine. In the example below,
  # accessing "localhost:8080" will access port 80 on the guest machine.
  # NOTE: This will enable public access to the opened port
  # config.vm.network "forwarded_port", guest: 80, host: 8080

  # Create a forwarded port mapping which allows access to a specific port
  # within the machine from a port on the host machine and only allow access
  # via 127.0.0.1 to disable public access
  # config.vm.network "forwarded_port", guest: 80, host: 8080, host_ip: "127.0.0.1"

  # Create a private network, which allows host-only access to the machine
  # using a specific IP.
  # config.vm.network "private_network", ip: "192.168.33.10"

  # Create a public network, which generally matched to bridged network.
  # Bridged networks make the machine appear as another physical device on
  # your network.
  # config.vm.network "public_network"

  # Share an additional folder to the guest VM. The first argument is
  # the path on the host to the actual folder. The second argument is
  # the path on the guest to mount the folder. And the optional third
  # argument is a set of non-required options.
  # config.vm.synced_folder "../data", "/vagrant_data"

  # Provider-specific configuration so you can fine-tune various
  # backing providers for Vagrant. These expose provider-specific options.
  # Example for VirtualBox:
  #
  # config.vm.provider "virtualbox" do |vb|
  #   # Display the VirtualBox GUI when booting the machine
  #   vb.gui = true
  #
  #   # Customize the amount of memory on the VM:
  #   vb.memory = "1024"
  # end
  #
  # View the documentation for the provider you are using for more
  # information on available options.

  # Enable provisioning with a shell script. Additional provisioners such as
  # Puppet, Chef, Ansible, Salt, and Docker are also available. Please see the
  # documentation for more information about their specific syntax and use.
  # config.vm.provision "shell", inline: <<-SHELL
  #   apt-get update
  #   apt-get install -y apache2
  # SHELL
end
