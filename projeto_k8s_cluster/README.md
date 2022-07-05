# Treinamento Descomplicando o Ansible

Projeto do trinamento para instalação de um cluster Kubernetes utilizando o Ansible + AWS.
Projeto com contribuição dos alunos.

## Fases do projeto
```
- Provisioning => Criar as instancias/vms para nosso cluster
- Install_K8s => Criação do cluster, etc.
- Deploy_app => deploy de uma aplicação exemplo
- Extra => Segredo
```

## Docs

Como pegar a ID da imagem na AWS. Abaixo busca a imagem mais atual do Ubuntu 20.04 LTS com Owner a Canonical:

```
aws ec2 describe-images \
 --region="us-east-1" \
 --owner=099720109477 \
 --filters Name=name,Values='*ubuntu/images/hvm-ssd/ubuntu-focal-20.04-amd64*' \
 --query 'Images[*].[ImageId,CreationDate]' \
 --output text | sort -k2 -r | head -n1 | cut -f1 -d$'\t'
```

Antes de iniciar o deploy com **ansible-playbook -i hosts main.yml** deve-se configurar a chave para acesso as instancias:

https://docs.ansible.com/ansible/latest/user_guide/connection_details.html

```
$ export ANSIBLE_HOST_KEY_CHECKING=False
$ ssh-agent zsh
$ ssh-add ~/.ssh/keypair.pem
```


## TERMINANDO AS INSTANCIAS

***ATENÇÃO***  
Este comando APAGA as instancias que tem dua tag PROJETO o value APAGAR. Esta tag está sendo colocada na task [provisioning](./provisioning/roles/criando-instancias/tasks/provisioning.yml) e foi criada para em faze de testes não precisar logar na console para apagar a infra.

```
aws ec2 terminate-instances --instance-ids $(aws ec2 describe-instances --query 'Reservations[].Instances[].InstanceId' --filters "Name=tag:Name,Values=ansible*" --filters Name=instance-state-name,Values=running --output text)
```    
# Links importantes:

## Ansible + AWS

https://www.ansible.com/integrations/cloud/amazon-web-services

https://docs.ansible.com/ansible/latest/scenario_guides/guide_aws.html

https://docs.ansible.com/ansible/latest/modules/list_of_all_modules.html

https://docs.ansible.com/ansible/latest/modules/list_of_cloud_modules.html

https://docs.ansible.com/ansible/latest/modules/ec2_module.html

https://docs.ansible.com/ansible/latest/modules/ec2_group_module.html

https://galaxy.ansible.com/docs/contributing/creating_role.html



## Para criar readme.md

https://www.makeareadme.com/



## License
[MIT](https://choosealicense.com/licenses/mit/)