# -*- mode: ruby -*-
# vi: set ft=ruby  :



machines = {
  # "debian/buster64"    - Ubuntu 16
  # "bento/ubuntu-20.04" - Ubuntu 20.04
  "ansible1"   => {"memory" => "1024", "cpu" => "1", "ip" => "101", "image" => "bento/ubuntu-20.04", 'provision' => 'install.sh'},
  "ansible2"   => {"memory" => "1024", "cpu" => "1", "ip" => "102", "image" => "bento/ubuntu-20.04", 'provision' => 'install.sh'},
  "ansible3"   => {"memory" => "1024", "cpu" => "1", "ip" => "103", "image" => "bento/ubuntu-20.04", 'provision' => 'install.sh'}
}

Vagrant.configure("2") do |config|

  config.vm.box_check_update = false
  machines.each do |name, conf|
    config.vm.define "#{name}" do |machine|
      if Vagrant.has_plugin?("vagrant-vbguest")
        config.vbguest.auto_update = false  
      end
      machine.vm.box = "#{conf["image"]}"
      machine.vm.network "private_network", ip: "10.11.22.#{conf["ip"]}"
      machine.vm.provider "virtualbox" do |vb|
        vb.name = "#{name}"
        vb.memory = conf["memory"]
        vb.cpus = conf["cpu"]
        vb.customize ["modifyvm", :id, "--groups", "/php-lab"]
      end
      # machine.vm.provision "file", source: "~/.ssh/id_rsa.pub", destination: "/home/vagrant/.ssh/id_rsa.pub.usuario"
      # $ mkdir .ssh
      # $ ssh-keygen -f .ssh/keys
      machine.vm.provision "file", source: ".ssh/keys.pub", destination: "/home/vagrant/.ssh/id_rsa.pub.usuario"
      machine.vm.provision 'shell', path: "ubuntu/#{conf['provision']}"
      machine.vm.provision "shell", inline: <<-SHELL
        sudo hostnamectl set-hostname #{name}
        sudo echo 10.11.22.101  ansible1 > /etc/hosts
        sudo echo 10.11.22.102  ansible2 >> /etc/hosts
        sudo echo 10.11.22.103  ansible3 >> /etc/hosts
      SHELL
      if "#{name}" == "ansible1"
        machine.vm.provision "shell", inline: <<-SHELL
          sudo apt update
          sudo apt install software-properties-common -y
          sudo add-apt-repository --yes --update ppa:ansible/ansible
          sudo apt install ansible -y
        SHELL
      end
    end
  end
end
