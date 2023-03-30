#!bin/bash
cleaninstall() {
apt="sudo apt -y"
sys="sudo systemctl"
$apt update;$apt install resolvconf
$apt remove avahi-daemon;$apt remove cups;$apt remove cups-browsed;$apt remove cups-daemon
$sys stop avahi-daemon;$sys stop cups;$sys stop cups-daemon;$sys stop systemd-resolved
$sys disable avahi-daemon;$sys disable cups;$sys disable cups-daemon;$sys disable systemd-resolved
$apt purge avahi-daemon;$apt purge cups;$apt purge cups-browsed;$apt purge cups-daemon
$sys start resolvconf;$sys enable resolvconf
sudo echo "nameserver 1.1.1.1
nameserver 9.9.9.9
nameserver 8.8.8.8
nameserver 8.8.4.4" > /etc/resolvconf/resolv.conf.d/tail
sudo mv /etc/resolv.conf /etc/resolv.conf.bkp;sudo ln -s /etc/resolvconf/resolv.conf.d/tail /etc/resolv.conf;sudo sysctl -p
}
cleaninstall
