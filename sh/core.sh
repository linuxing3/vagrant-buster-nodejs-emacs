echo "==========================================================="
echo "update packages"
echo "==========================================================="

echo "Install core tools"
sudo apt-get -y update
sudo apt-get install -y tmux
sudo apt-get install -y git
sudo apt-get install -y wget curl elinks

echo "Install build tools"
sudo apt-get install -y build-essential
sudo apt-get install -y python3 python-pip g++ make
sudo apt-get install -y libcairo2-dev nfs-common portmap

sudo pip install ansible