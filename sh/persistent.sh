echo "Creating persistent storage..."
echo "======================================================================================"
persistent_mount='/var/cache/apt/archives none bind 0 0'

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