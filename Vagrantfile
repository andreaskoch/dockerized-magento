# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant.configure(2) do |config|
  config.vm.box = "ubuntu/trusty64"

  config.vm.network "forwarded_port", guest: 80, host: 80
  config.vm.network "forwarded_port", guest: 443, host: 443
  config.vm.network "forwarded_port", guest: 3306, host: 3306
  config.vm.network "forwarded_port", guest: 8983, host: 8983

  config.vm.provider "virtualbox" do |vb|
    vb.memory = "2048"
  end

  config.push.define "atlas" do |push|
    push.app = "andreaskoch/dockerized-magento"
  end

  config.vm.provision "shell", inline: <<-SHELL
    echo "Install Utilities"
    sudo apt-get update
    sudo apt-get install -y git-core vim wget curl

    echo "Install Docker"
    wget -qO- https://get.docker.com/ | sudo sh

    echo "Enable non-root access for docker"
    sudo groupadd docker
    sudo gpasswd -a ${USER} docker
    sudo service docker restart # will only take effect for the next login

    echo "Install docker-compose"
    sudo curl -L https://github.com/docker/compose/releases/download/1.1.0/docker-compose-`uname -s`-`uname -m` > /usr/local/bin/docker-compose
    sudo chmod +x /usr/local/bin/docker-compose

    echo "Start Magento"
    sudo /vagrant/magento start
  SHELL
end
