# frozen_string_literal: true

# -*- mode: ruby -*-
# vi: set ft=ruby :

required_plugins = %w[vagrant-reload vagrant-persistent-storage nugrant]
plugins_to_install = required_plugins.reject { |plugin| Vagrant.has_plugin? plugin }

unless plugins_to_install.empty?
  puts "Installing plugins: #{plugins_to_install.join(' ')}"
  if system "vagrant plugin install #{plugins_to_install.join(' ')}"
    exec "vagrant #{ARGV.join(' ')}"
  else
    abort 'Installation of one or more plugins has failed. Aborting.'
  end
end

vagrant_dir = __dir__

Vagrant.configure("2") do |config|
  config.vm.box = "buster32"

  default_vb_audio = nil
  default_vb_audiocontroler = 'hda'
  if Vagrant::Util::Platform.windows?
    default_vb_audio = 'dsound'
  elsif Vagrant::Util::Platform.platform =~ /darwin/
    default_vb_audio = 'coreaudio'
    default_vb_audiocontroler = 'hda'
  end

  config.user.defaults = {
    'vm' => {
      'workspace_dir'=> '../../../../workspace',
      'dropbox_dir' => '../../../../Dropbox',
    },
    'ansible' => {
      'skip_tags' => []
    },
    'virtualbox' => {
      'name' => 'editor',
      'gui' => false,
      'cpus' => 1,
      'graphicscontroller' => nil,
      'accelerate3d' => 'off',
      'memory' => '1024',
      'clipboard' => 'bidirectional',
      'draganddrop' => 'bidirectional'
    },
    'timezone' => 'Europe/London',
    'locales' => {
      'default' => 'en_GB.UTF-8',
      'present' => ['en_GB.UTF-8', 'en_US.UTF-8']
    },
    'keyboard' => {
      'model' => 'pc105',
      'layout' => 'gb',
      'variant' => ''
    },
    'dock_position' => 'LEFT',
    'git_user' => {
      'name' => nil,
      'email' => nil,
      'force' => false
    },
    'persistent_storage_location' => '../box/editor-persistent-disk.vmdk'
  }

  # Setting ssh port
  # config.ssh.port = config.user.vm.ssh_port

  # Setting persistent storage
  config.persistent_storage.enabled = true
  config.persistent_storage.location = config.user.persistent_storage_location
  config.persistent_storage.size = 16_000
  config.persistent_storage.mountname = 'persistent'
  config.persistent_storage.filesystem = 'ext4'
  config.persistent_storage.mountpoint = '/var/persistent'
  config.persistent_storage.volgroupname = 'persist-vg'

  config.vm.provider 'virtualbox' do |vb|
    # Give the VM a name
    vb.name = config.user.virtualbox.name

    # Display the VirtualBox GUI when booting the machine
    vb.gui = config.user.virtualbox.gui

    # Customize CPU settings
    vb.cpus = config.user.virtualbox.cpus

    # Customize the amount of memory on the VM
    vb.memory = config.user.virtualbox.memory

    # Enable host desktop integration
    vb.customize ['modifyvm', :id, '--clipboard', config.user.virtualbox.clipboard]
    vb.customize ['modifyvm', :id, '--draganddrop', config.user.virtualbox.draganddrop]

  end

  # Mounting my dirs
  # config.vm.synced_folder "../../../../workspace", "/home/vagrant/workspace"
  # config.vm.synced_folder "../../../../Dropbox", "/home/vagrant/Dropbox"
  config.vm.synced_folder config.user.vm.workspace_dir, "/home/vagrant/workspace"
  config.vm.synced_folder config.user.vm.dropbox_dir, "/home/vagrant/Dropbox"

  # Perform preliminary persistent storage
  config.vm.provision "shell", path: "sh/persistent.sh"
  # Perform
  # config.vm.provision "shell", path: "sh/core.sh"

  # Perform preliminary setup before the main Ansible provisioning
  # config.vm.provision 'ansible_local' do |ansible|
  #   ansible.playbook = 'ansible/hackbook.yml'
  #   ansible.skip_tags = config.user.ansible.skip_tags
  #   ansible.extra_vars = {      
  #    git_user_name: config.user.git_user.name,
  #    git_user_email: config.user.git_user.email,
  #    git_user_force: config.user.git_user.force
  #  }
  # end
end