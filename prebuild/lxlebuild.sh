#!bin/bash
sysctl() {
echo "# Set the kernel panic timeout to 10 seconds
kernel.panic=10
# Randomize the memory layout of the kernel to make it harder for attackers
kernel.randomize_va_space=2
# Enable kernel executable space protection
kernel.exec-shield = 2
# Use PID as core filename
kernel.core_uses_pid = 1
# Restrict access to kernel log buffer
kernel.dmesg_restrict = 1
# Restrict access to kernel pointers
kernel.kptr_restrict = 2
# Panic the system if a kernel oops occurs
kernel.panic_on_oops = 60
# Restrict access to perf events
kernel.perf_event_paranoid = 3
# Disable the sysrq key
kernel.sysrq = 0
# Disable unprivileged access to BPF (Berkeley Packet Filter) system calls
kernel.unprivileged_bpf_disabled = 1
# Set the ptrace scope to only allow tracing of direct child processes
kernel.yama.ptrace_scope = 2
# Increase the maximum number of process IDs to 65536
kernel.pid_max = 65536
# Reduce swapping
vm.swappiness = 10
# Set the ratio of memory pages allowed to get dirty to 60%
vm.dirty_ratio = 60
# Set the ratio of memory pages allowed to remain dirty to 2%
vm.dirty_background_ratio = 2
# Disable automatic loading of line disciplines for tty devices
dev.tty.ldisc_autoload = 0
# Increase the maximum number of open files to 65535
fs.file-max = 65535
# Set FIFOs protection level to 2 (only owner can read/write)
fs.protected_fifos = 2
# Disable setuid dumps
fs.suid_dumpable = 0
# Enable protection of hardlinks against modification
fs.protected_hardlinks=0
# Enable protection of symbolic links against exploitation
fs.protected_symlinks=0
# Enable Fair Queue packet scheduler as the default queuing discipline
net.core.default_qdisc = fq
# Set the default receive buffer size for all protocols to 256KB
net.core.rmem_default = 262144
# Set the maximum receive buffer size for all protocols to 16MB
net.core.rmem_max = 16777216
# Set the default send buffer size for all protocols to 256KB
net.core.wmem_default = 262144
# Set the maximum send buffer size for all protocols to 16MB
net.core.wmem_max = 16777216
# Set the maximum length of the listen queue backlog
net.core.somaxconn = 32768
# Set the maximum number of packets that can be queued on the input side of each network interface
net.core.netdev_max_backlog = 16384
# Set the default weight of all network interfaces to 64
net.core.dev_weight = 64
# Set the maximum socket buffer size allocatable to a single socket
net.core.optmem_max = 65535
# Enable hardened Berkeley Packet Filter (BPF) JIT compiler
net.core.bpf_jit_harden = 2
# Set the maximum receive buffer size for TCP connections to 8MB
net.ipv4.tcp_rmem_max = 8388608
# Set the maximum send buffer size for TCP connections to 8MB
net.ipv4.tcp_wmem_max = 8388608
# Set the maximum length of the listen queue backlog for all protocols to 5000
net.core.netdev_max_backlog = 5000
#Set the default receive buffer size for TCP connections
net.ipv4.tcp_rmem = 4096 87380 6291456
#Set the maximum receive buffer size for TCP connections to 16MB
net.ipv4.tcp_rmem_max = 16777216
#Set the maximum number of sockets allowed to queue up for accepting connections to 500
net.core.somaxconn = 500
#Enable TCP window scaling
net.ipv4.tcp_window_scaling = 1
#Enable TCP timestamps
net.ipv4.tcp_timestamps = 1
#Enable TCP selective acknowledgements
net.ipv4.tcp_sack = 1
#Enable TCP Fast Open
net.ipv4.tcp_fastopen = 3
#Increase TCP maximum syn backlog
net.ipv4.tcp_max_syn_backlog = 4096
#Increase the maximum number of open file descriptors
fs.file-max = 2097152
#Increase the maximum amount of memory allocated to each socket receive buffer
net.core.rmem_max = 16777216
#Increase the maximum amount of memory allocated to each socket send buffer
net.core.wmem_max = 16777216
#Increase the default amount of memory allocated to each socket receive buffer
net.core.rmem_default = 16777216
#Increase the default amount of memory allocated to each socket send buffer
net.core.wmem_default = 16777216
#Enable low latency mode
net.core.busy_poll = 50
#Decrease the amount of time a connection spends in the 'TIME_WAIT' state
net.ipv4.tcp_fin_timeout = 10
#Enable TCP keepalive
net.ipv4.tcp_keepalive_time = 1200
net.ipv4.tcp_keepalive_intvl = 30
net.ipv4.tcp_keepalive_probes = 3
#Enable SYN cookies
net.ipv4.tcp_syncookies = 1
#Enable automatic congestion control
net.ipv4.tcp_congestion_control = cubic
#Enable explicit congestion notification
net.ipv4.tcp_ecn = 2
#Disable TCP slow start after idle for 120 seconds
net.ipv4.tcp_slow_start_after_idle = 0
#Enable TCP window scaling
net.ipv4.tcp_window_scaling = 1
#Enable TCP selective acknowledgments
net.ipv4.tcp_sack = 1
#Enable TCP Fast Open
net.ipv4.tcp_fastopen = 3
#Enable TCP timestamps
net.ipv4.tcp_timestamps = 1
#Increase TCP buffer limits
net.core.rmem_max = 16777216
net.core.wmem_max = 16777216
net.ipv4.tcp_rmem = 4096 87380 16777216
net.ipv4.tcp_wmem = 4096 65536 16777216
#Increase the maximum number of open files and file descriptors
ulimit -n 1000000
#Increase the maximum number of user processes
ulimit -u 2048
#Increase the maximum number of memory map areas a process may have
vm.max_map_count = 262144" > /etc/sysctl.conf
sudo sysctl -p
}

packages() {
sudo systemctl stop cups && sudo systemctl stop avahi-daemon && sudo systemctl stop ntp && sudo systemctl stop nmb
sudo systemctl disable cups && sudo systemctl disable avahi-daemon && sudo systemctl disable ntp && sudo systemctl disable nmb
sudo apt -y remove --purge cups avahi-daemon ntp nmb && sudo apt -y remove --purge libreoffice*
sudo apt -y remove --purge homebank* && sudo apt -y remove --purge pycrust
sudo apt -y remove --purge xrced && sudo apt -y remove --purge osmo*
sudo apt -y remove --purge bookworm* && sudo apt -y remove --purge viewnior
sudo apt -y remove --purge imagemagick* && sudo apt -y remove --purge blanket*
sudo apt -y remove --purge audacity* && sudo apt -y remove --purge liferea
sudo apt -y remove --purge clawsmail && sudo apt -y remove --purge compton*
sudo apt -y remove --purge utox* && sudo apt -y remove --purge qlipper*
sudo apt -y remove --purge noblenote* && sudo apt -y remove --purge 2048-qt*
sudo apt -y remove --purge bluez* && sudo apt -y remove --purge quassel*
sudo apt -y remove --purge trojita* && sudo apt -y remove --purge transmission mate-utils mate-utils-common
sudo apt -y remove --purge gadmin* && sudo apt -y remove --purge samba* bleachbit* guvcview xfburn*
sudo apt -y remove --purge guayadeque handbrake eboard && sudo apt -y remove --purge com.github.babluboy.bookworm
sudo apt -y remove --purge aspell-en cracklib-runtime hunspell-en-us libgdbm-compat4 libgdbm3 libgdbm6 liblouis-data libmatedict6
sudo apt -y remove --purge lxde* lxrandr libilmbase24 && sudo apt -y remove --purge rsync sntp tcpd telnet xzoom libxrandr2
sudo apt -y remove --purge xcal tcl bc dc deborphan psmisc aptitude fortune && sudo apt -y remove --purge --allow-remove-essential dash xterm
sudo apt -y remove --purge peg-e zaz connectagram && sudo apt -y remove --purge simple-image-reducer && sudo apt -y remove --purge cups avahi-daemon 
sudo apt -y remove --purge samba*
sudo apt -y remove --purge smbclient
}

config() {
sudo rm -r /etc/apt/sources.list.d/* && sudo sed -i 's/us\.//g' /etc/apt/sources.list
sudo sed -i 's/deb http://downloads.sourceforge.net/project/ubuntuzilla/mozilla/apt/ all main//g' /etc/apt/sources.list
sudo sed -i 's/deb [trusted=yes] file:/cdrom/dists/ ./  # ISO repo - BB//g' /etc/apt/sources.list
sudo ufw enable && sudo ufw allow out 80
sudo echo -ne -n -e "nameserver 1.1.1.1\nnameserver 9.9.9.9" > /etc/resolvconf/resolv.conf.d/tail
sudo systemctl stop systemd-resolved && sudo systemctl disable systemd-resolved && sudo systemctl start resolvconf
sudo systemctl enable resolvconf && sudo mv /etc/resolv.conf /etc/resolv.conf.bkp
sudo ln -s /etc/resolvconf/resolv.conf.d/tail /etc/resolv.conf
sudo cp -r /media/qwerty/86ACDBF8ACDBE12B/Users/user/Desktop/1/i2pd/security.profile /etc/gufw/app_profiles/security.profile
sudo apt -y update && sudo apt -y install gufw
sudo apt -y install obconf-qt obsession openbox openbox-menu net-tools pcmanfm && sudo apt -y install featherpad tor
sudo systemctl stop avahi-daemon && sudo systemctl disable avahi-daemon
sudo addgroup $USER audio
sudo apt -y install pavucontrol;sudo apt -y install pulseaudio
pulseaudio --stop
pulseaudio --start
sudo apt -y remove --purge samba*
sudo apt -y remove --purge smbclient
}

iptables() {
sudo modprobe ipt_owner
ipt=$(sudo iptables)
uid=$(ps -C waterfox -o uid=)
uid2=$(ps -C tor -o uid=)
uid3=$(ps -C http -o uid=)
iplocal=$(ip addr show | grep 'inet ' | grep -v '127.0.0.1' | awk '{print $2}' | cut -f1 -d'/')
sudo modprobe ipt_owner
$ipt -A OUTPUT -m owner --uid-owner $uid -p tcp -s $iplocal --dport 443 -j ACCEPT
$ipt -A OUTPUT -m owner --uid-owner $uid2 -p tcp -s 127.0.0.1 --sport 9050 -j ACCEPT
$ipt -A OUTPUT -m owner --uid-owner $uid3 -p tcp -s $iplocal --dport 443 -j ACCEPT
}

network() {
iplocal="x"
read -p "What is your ip address of Gateway? Example: 192.168.0.1" iplocal
read -p "What is your ip address of LocalHost? Example: 192.168.0.15" iprouter
sudo echo > /etc/NetworkManager/system-connections/'Wired connection 1.nmconnection'
sudo echo -ne -n -e "[connection]\nid=Wired connection 1\nuuid=13bcb68f-de1d-39df-ae30-9bcc7964ce9a\ntype=ethernet\nautoconnect-priority=-999\ninterface-name=enp3s0\npermissions=user:qwerty:;\n[ethernet]\ncloned-mac-address=stable\nmac-address-blacklist=\nwake-on-lan=32768\n[ipv4]\naddress1=${iplocal}/32,${iprouterl}\ndns=1.1.1.1;9.9.9.9;\ndns-search=\nmethod=manual\n[ipv6]\naddr-gen-mode=stable-privacy\ndns-search=\nip6-privacy=0\nmethod=disabled\n[proxy]" > /etc/NetworkManager/system-connections/'Wired connection 1.nmconnection'
}

florence() {
sudo apt -y update
sudo apt -y install florence
echo -ne -n -e "#!/usr/bin/env\n[Desktop Entry]\nType=Application\nName=Florence\nGenericName=VirtualKeyboard\nComment= To Start the floroence\nCategories=Keyboard\nExec=sh -c florence\nStartupWMClass=Florence\n" > ~/florence.desktop
}


sysctl
packages
config
network
iptables
florence
pavucontrol
