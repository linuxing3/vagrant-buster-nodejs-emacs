echo "==========================================================="
echo "installing python3"
echo "==========================================================="

sudo apt-get install -y python3 python3-pip
# Make sure to use python 3
sudo rm /usr/bin/python
sudo ln -s /usr/bin/python3 /usr/bin/python
sudo rm /usr/bin/pip
sudo ln -s /usr/bin/pip3 /usr/bin/pip


cd
# using ansible
pip3 install --user ansible
# using pipenv
pip3 install --user pipenv
echo "export PATH=$PATH:/home/vagrant/.local/bin" >> /home/vagrant/.bashrc