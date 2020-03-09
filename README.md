# Debian Buster with nodejs

## Install and provision

```bash
vagrant box add --name "buster32" $YOUR_BOX_FILE
vagrant up
vagrant provision
vagrant ssh-config
```

## Put your `ssh keys` in `keys` directory as you like

## If you want provision with `ansible`, use the following settings

```yml
  config.vm.provision :ansible do |ansible|
    ansible.sudo = true
    ansible.sudo_user = "root"
    ansible.playbook = "ansible/playbook.yml"
    ansible.inventory_path = "ansible/hosts"
    ansible.verbose = true
  end
```