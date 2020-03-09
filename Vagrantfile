# frozen_string_literal: true

# -*- mode: ruby -*-
# vi: set ft=ruby :

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

vagrant_dir = __dir__

Vagrant.configure("2") do |config|
  config.vm.box = "buster32"

  config.user.defaults = {
    'proxy' => {
      'enabled' => false,
      'http' => 'http://example.com:3128/',
      'https' => 'http://example.com:3128/',
      'ftp' => 'http://example.com:3128/',
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
    'virtualbox' => {
      'name' => 'development-environment',
      'gui' => false,
      'cpus' => 1,
      'graphicscontroller' => nil,
      'accelerate3d' => 'off',
      'memory' => '1024',
      'clipboard' => 'bidirectional',
      'draganddrop' => 'bidirectional',
      'audio' => default_vb_audio,
      'audiocontroller' => default_vb_audiocontroler
    }
  }

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

    unless config.user.virtualbox.audio.nil?
      # Enable sound
      vb.customize ['modifyvm', :id, '--audio', config.user.virtualbox.audio, '--audiocontroller', config.user.virtualbox.audiocontroller]
    end
  end

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

  config.vm.synced_folder "../../../../workspace", "/home/vagrant/workspace"
  config.vm.synced_folder "../../../../Dropbox", "/home/vagrant/Dropbox"
  config.vm.provision "shell", path: "sh/provision.test.sh"
end