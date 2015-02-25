# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant.configure(2) do |config|
  # Box
  config.vm.box = "ubuntu/trusty64"

  # Port Forwarding
  config.vm.network "forwarded_port", guest: 8000, host: 8000 # Django
  config.vm.network "forwarded_port", guest: 5432, host: 5432 # PostgreSQL

  # Customization
  config.vm.provider "virtualbox" do |vb|
    vb.customize ["modifyvm", :id, "--natdnshostresolver1", "on"]
    vb.customize ["modifyvm", :id, "--memory", "1024"]
  end

  # Provisioning
  config.vm.provision "shell", path: "vagrant/install.sh"
  config.vm.provision "shell", path: "vagrant/setup.sh", privileged: false
end
