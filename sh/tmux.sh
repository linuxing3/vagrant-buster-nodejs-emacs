echo "==========================================================="
echo "installing tmux"
echo "==========================================================="

VAGRANT_HOME="/home/vagrant"
cd $VAGRANT_HOME
git clone https://github.com/gpakosz/.tmux.git
ln -s -f .tmux/.tmux.conf
cp .tmux/.tmux.conf.local .