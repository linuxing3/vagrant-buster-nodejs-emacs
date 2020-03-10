# frozen_string_literal: true

# -*- mode: ruby -*-
# vi: set ft=ruby :

required_plugins = %w[vagrant-reload vagrant-persistent-storage vagrant-proxyconf nugrant]
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
      'ssh_port' => '8022',
      'work_dir': '../../../../workspace',
      'dropbox_dir': '../../../../Dropbox'
    },
    'proxy' => {
      'enabled' => false,
      'http' => 'http://10.0.0.2:3128/',
      'https' => 'http://10.0.0.2:3128/',
      'ftp' => 'http://10.0.0.2:3128/',
      'no_proxy' => 'localhost,127.0.0.1'
    },
    'apt_proxy' => {
      'http' => nil,
      'https' => nil,
      'ftp' => nil
    },
    'git_proxy' => {
      'http' => nil
    },
    'ansible' => {
      'skip_tags' => []
    },
    'virtualbox' => {
      'name' => 'development-environment',
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
    'persistent_storage_location' => '.vagrant/persistent-disk.vdi'
  }

  # Setting ssh port
  config.ssh.port = config.user.vm.ssh_port

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

  # Customfile
  #
  # Use this to insert your own (and possibly rewrite) Vagrant config lines.
  # If a file 'Customfile' exists in the same directory as this Vagrantfile,
  # it will be evaluated as ruby inline as it loads.
  # if File.exist?(File.join(vagrant_dir, 'Customfile'))
  #   eval(IO.read(File.join(vagrant_dir, 'Customfile')), binding)
  # end


  if config.user.proxy.enabled
    config.proxy.enabled = config.user.proxy.enabled
    config.proxy.http = config.user.proxy.http
    config.proxy.https = config.user.proxy.https
    config.proxy.ftp = config.user.proxy.ftp
    config.proxy.no_proxy = config.user.proxy.no_proxy
    config.apt_proxy.http = config.user.apt_proxy.http
    config.apt_proxy.https = config.user.apt_proxy.https
    config.apt_proxy.ftp = config.user.apt_proxy.ftp
    config.git_proxy.http = config.user.git_proxy.http
  end

  # Mounting my dirs
  config.vm.synced_folder config.user.vm.work_dir, "/home/vagrant/workspace"
  config.vm.synced_folder config.user.vm.dropbox_dir, "/home/vagrant/Dropbox"

  # Perform preliminary persistent storage
  config.vm.provision "shell", path: "sh/persistent.sh"
  # Perform
  config.vm.provision "shell", path: "sh/provision.test.sh"

  # Perform preliminary setup before the main Ansible provisioning
  config.vm.provision 'ansible_local' do |ansible|
    ansible.playbook = 'ansible/hackbook.yml'
    ansible.skip_tags = config.user.ansible.skip_tags
    ansible.extra_vars = {      
     git_user_name: config.user.git_user.name,
     git_user_email: config.user.git_user.email,
     git_user_force: config.user.git_user.force
   }
  end
end