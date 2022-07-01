# -*- mode: ruby -*-
# vi: set ft=ruby  :



machines = {
  # "debian/buster64"    - Ubuntu 16
  # "bento/ubuntu-20.04" - Ubuntu 20.04
  "ansible1"   => {"memory" => "1024", "cpu" => "1", "ip" => "100", "image" => "bento/ubuntu-20.04", 'provision' => 'install.sh'},
  "ansible2"   => {"memory" => "1024", "cpu" => "1", "ip" => "101", "image" => "bento/ubuntu-20.04", 'provision' => 'install.sh'},
  "ansible3"   => {"memory" => "1024", "cpu" => "1", "ip" => "102", "image" => "bento/ubuntu-20.04", 'provision' => 'install.sh'}
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
      machine.vm.provision "shell", inline: <<-SHELL
        sudo hostnamectl set-hostname #{name}
      SHELL
      # if "#{name}" == "php"
        machine.vm.provision "file", source: "~/.ssh/id_rsa.pub", destination: "/home/vagrant/.ssh/id_rsa.pub.usuario"
        machine.vm.provision 'shell', path: "ubuntu/#{conf['provision']}"
      # end
    end
  end
end
