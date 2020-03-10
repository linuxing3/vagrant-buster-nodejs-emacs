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

## if you need to do provision as `vagrant` user

```bash
su -c "source do_some_setting.sh" vagrant
```

## I you need persistent storage

In you `Vagrantfile`, adding plugins

```yml
  required_plugins = %w[vagrant-reload vagrant-persistent-storage vagrant-vbguest vagrant-proxyconf nugrant]
  plugins_to_install = required_plugins.reject { |plugin| Vagrant.has_plugin? plugin }

  unless plugins_to_install.empty?
    puts "Installing plugins: #{plugins_to_install.join(' ')}"
    if system "vagrant plugin install #{plugins_to_install.join(' ')}"
      exec "vagrant #{ARGV.join(' ')}"
    else
      abort 'Installation of one or more plugins has failed. Aborting.'
    end
  end


  Vagrant.configure("2") do |config|
    config.vm.box = "buster32"
    config.persistent_storage.enabled = true
    config.persistent_storage.location = config.user.persistent_storage_location
    config.persistent_storage.size = 16_000
    config.persistent_storage.mountname = 'persistent'
    config.persistent_storage.filesystem = 'ext4'
    config.persistent_storage.mountpoint = '/var/persistent'
    config.persistent_storage.volgroupname = 'persist-vg'
    config.vm.provision "shell", path: "persistent.sh"
  end
```

In your script file `persistent.sh`
```sh
echo "Creating persistent storage..."
echo "======================================================================================"
persistent_mount='/var/persistent/var/cache/apt/archives /var/cache/apt/archives none bind 0 0'

mkdir -p /var/persistent/var/cache/apt/archives \
&& grep -q -F "${persistent_mount}" /etc/fstab || echo "${persistent_mount}" >> /etc/fstab \
&& mount /var/cache/apt/archives

persistent_mount='/var/persistent/usr/local/src/ansible/data /usr/local/src/ansible/data none bind 0 0'
mkdir -p /var/persistent/usr/local/src/ansible/data \
mkdir -p /usr/local/src/ansible/data \
&& grep -q -F "${persistent_mount}" /etc/fstab || echo "${persistent_mount}" >> /etc/fstab \
&& mount /usr/local/src/ansible/data

echo "Created persistent storage..."
echo "======================================================================================"
```