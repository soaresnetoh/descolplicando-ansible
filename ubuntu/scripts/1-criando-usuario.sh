#!/bin/bash
### vars.sh ####
USER='usuario'
PASS='usuario02'

addUsers () {
    #criando o usuário suporte
    useradd -m -d "/home/${USER}" -p $(openssl passwd -1 ${PASS}) -s /bin/bash ${USER} -G sudo

    # aqui a chave compartilhada atraves do vagrantfile é adicionado ao authorized_keys do user usuario
    #config.vm.provision :shell, :inline => "cat /home/vagrant/.ssh/id_rsa.pub >> /home/vagrant/.ssh/authorized_keys", run: "always"
    mkdir -p /home/usuario/.ssh/
    cat /home/vagrant/.ssh/id_rsa.pub.usuario >> /home/usuario/.ssh/authorized_keys
    cat /home/vagrant/.ssh/id_rsa.pub.usuario  > /home/usuario/.ssh/id_rsa.pub
    cat /home/vagrant/.ssh/id_rsa.usuario      > /home/usuario/.ssh/id_rsa
    chown usuario:usuario -R /home/usuario/.ssh
    chown usuario:usuario /home/usuario/.ssh/id_rsa.pub
    chmod 600 /home/usuario/.ssh/id_rsa
    chmod 644 /home/usuario/.ssh/id_rsa.pub
    rm cat /home/vagrant/.ssh/id_rsa.pub.usuario
    rm cat /home/vagrant/.ssh/id_rsa.usuario

    #alterando a senha do usuario vagrant
    sudo usermod -p $(openssl passwd -1 ${PASS}) vagrant

    #alterando a senha do root
    sudo usermod -p $(openssl passwd -1 ${PASS}) root
}

addUsers