cd
echo "==========================================================="
cp /vagrant/sh/.gitconfig /home/vagrant/.gitconfig
cp /vagrant/sh/.git-credentials /home/vagrant/.git-credentials

echo "Run 'vagrant ssh' then set your git config manually, e.g.:"
echo "ssh-keygen -t rsa"
echo "(Copy the contents of ~/.ssh/id_rsa.pub into your GitHub account: https://github.com/settings/ssh)"