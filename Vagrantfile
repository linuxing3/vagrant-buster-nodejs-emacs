Vagrant.configure("2") do |config|
  config.vm.box = "buster32"
  config.vm.synced_folder "../../../../workspace", "/home/vagrant/workspace"
  config.vm.synced_folder "../../../../Dropbox", "/home/vagrant/Dropbox"
  # config.vm.provision "shell", path: "sh/provision.sh"
  config.vm.provision "ansible", path: "ansible/nodejs.yml"
end