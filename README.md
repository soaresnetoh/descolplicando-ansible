# Descomplicando o Ansible - com vagrant

## Sobre:

Este projeto está sendo criado para estudar o Ansible baseado no curso da LinuxTips Descomplicando o Ansible

## Pre-requisitos

ubuntu
vagrant
git

## Modo de uso

No ubuntu, na pasta de estudos:

clone o repo:
```bash
$ git clone <repo>
```

crie a chave ssh:
```bash
$ mkdir .ssh
$ ssh-keygen -f .ssh/keys
Generating public/private rsa key pair.
Enter passphrase (empty for no passphrase): 
Enter same passphrase again: 
Your identification has been saved in .ssh/keys
Your public key has been saved in .ssh/keys.pub
The key fingerprint is:
SHA256:oTsmNmP648OS6WPf4Up8MuVa6570CkADh7/S+dNclU8 usuario@L3419
The key's randomart image is:
+---[RSA 3072]----+
|...              |
|.o               |
| .o     .  .     |
| ...   . .o E    |
| ..o  o S. o     |
|. +o o ..   .    |
| . =%oX.         |
|  *=*/o*         |
| oo**BO..        |
+----[SHA256]-----+
```

suba as vms:
```bash
$ vagrant up
```

crie um acesso por dns as vms:
```bash
$ sudo vim /etc/hosts
10.11.22.101  ansible1
10.11.22.102  ansible2
10.11.22.103  ansible3

```

acesse a vm:
```bash
$ ssh -i .ssh/keys usuario@ansible1
```


para pegar as facts:
```bash
$ ansible -i hosts webservers -m setup
```

# Criando infra na AWS

[Acesse o projeto ansible-k8s-aws](./projeto_k8s_cluster/)