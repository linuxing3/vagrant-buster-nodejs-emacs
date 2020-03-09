# Stretch with nodejs

## ssh issue

```bash
vagrant reloadE
```

## intall nodejs

```bash
# install 10/11 is not availabe in stretch
sudo curl -sL https://deb.nodesource.com/setup_8.x | bash -
# better use nvm to install your node
curl -o- https://raw.githubusercontent.com/creationix/nvm/v0.34.0/install.sh | bash
# using pyenv
curl https://pyenv.run | bash
# using oh-my-bash, fish is not good in console2 and other win tty
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmybash/oh-my-bash/master/tools/install.sh)"
```
