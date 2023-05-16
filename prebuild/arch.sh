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
vm.max_map_count = 262144
net.ipv4.conf.all.accept_redirects=0
net.ipv4.conf.default.accept_redirects=0
net.ipv4.ip_forward=0
kernel.shmmax=67108864
kernel.shmall=16777216
net.ipv4.tcp_syncookies=1
net.ipv4.tcp_timestamps=0
net.ipv4.tcp_synack_retries=5
net.ipv4.tcp_syn_retries=5
net.ipv4.icmp_echo_ignore_broadcasts=1
net.ipv4.conf.all.rp_filter=1
net.ipv4.conf.default.rp_filter=1
kernel.pid_max=65536" > /etc/sysctl.conf
sudo sysctl -p
}

iptables() {
tr -cd '[:print:]\n' < cidrlist.txt > ccidrlist.txt
sudo iptables -F
sudo iptables -X
sudo iptables -Z
sudo iptables -P INPUT DROP
sudo iptables -P FORWARD DROP
sudo iptables -P OUTPUT DROP

while read ip; do sudo iptables -A INPUT -s "$ip" -j DROP; done < ccidrlist.txt
while read ip; do sudo iptables -A OUTPUT -s "$ip" -j DROP; done < ccidrlist.txt

sudo iptables -A INPUT -m state --state INVALID -j DROP
sudo iptables -A INPUT -p tcp --tcp-flags ALL FIN,URG,PSH -j DROP
sudo iptables -A INPUT -p tcp --tcp-flags ALL SYN,RST,ACK,FIN,URG -j DROP
sudo iptables -N flood
sudo iptables -A flood -m limit --limit 5/sec --limit-burst 10 -j RETURN
sudo iptables -A flood -j DROP
sudo iptables -A INPUT -p tcp --syn -j flood
sudo iptables -A INPUT -p tcp --tcp-flags SYN,ACK SYN,ACK -m conntrack --ctstate NEW -j DROP
sudo iptables -A INPUT -p tcp --tcp-flags FIN,ACK FIN,ACK -m conntrack --ctstate NEW -j DROP
sudo iptables -A INPUT -p tcp --tcp-flags ALL NONE -j DROP
sudo iptables -A INPUT -p tcp --tcp-flags ALL SYN,FIN,ACK -j DROP
sudo iptables -A INPUT -p tcp --tcp-flags ALL SYN,RST,ACK,FIN,URG -j DROP
sudo iptables -A INPUT -f -j DROP
sudo iptables -A INPUT -p tcp --tcp-flags ALL ALL -j DROP
sudo iptables -A INPUT -p tcp --tcp-flags ALL NONE -j DROP

sudo iptables -A INPUT -s 223.255.255.254/32 -d 170.245.12.0/22 -j DROP
sudo iptables -A INPUT -s 223.255.255.254/32 -d 189.90.51.52/30 -j DROP
sudo iptables -A INPUT -s 223.255.255.254/32 -d 143.137.72.128/25 -j DROP
sudo iptables -A INPUT -s 223.255.255.254/32 -d 200.186.135.236/30 -j DROP
sudo iptables -A INPUT -s 223.255.255.254/32 -d 177.53.240.132/30 -j DROP
sudo iptables -A INPUT -s 223.255.255.254/32 -d 177.53.240.192/26 -j DROP
sudo iptables -A INPUT -s 223.255.255.254/32 -d 200.186.191.76/30 -j DROP
sudo iptables -A INPUT -s 223.255.255.254/32 -d 200.186.168.56/30 -j DROP
sudo iptables -A INPUT -s 223.255.255.254/32 -d 191.37.248.0/22 -j DROP
sudo iptables -A INPUT -s 223.255.255.254/32 -d 189.90.56.48/30 -j DROP
sudo iptables -A INPUT -s 223.255.255.254/32 -d 189.125.21.220/30 -j DROP
sudo iptables -A INPUT -s 223.255.255.254/32 -d 177.53.240.0/25 -j DROP
sudo iptables -A INPUT -s 223.255.255.254/32 -d 177.53.240.144/28 -j DROP
sudo iptables -A INPUT -s 223.255.255.254/32 -d 45.237.108.0/22 -j DROP
sudo iptables -A INPUT -s 223.255.255.254/32 -d 177.53.244.0/22 -j DROP
sudo iptables -A INPUT -s 223.255.255.254/32 -d 45.166.204.0/22 -j DROP
sudo iptables -A INPUT -s 223.255.255.254/32 -d 143.137.72.0/26 -j DROP
sudo iptables -A INPUT -s 223.255.255.254/32 -d 177.53.242.0/23 -j DROP
sudo iptables -A INPUT -s 223.255.255.254/32 -d 177.53.241.0/24 -j DROP
sudo iptables -A INPUT -s 223.255.255.254/32 -d 189.125.8.52/30 -j DROP
sudo iptables -A INPUT -s 223.255.255.254/32 -d 177.53.240.160/27 -j DROP
sudo iptables -A INPUT -s 223.255.255.254/32 -d 143.137.72.96/29 -j DROP
sudo iptables -A INPUT -s 223.255.255.254/32 -d 143.137.73.0/24 -j DROP
sudo iptables -A INPUT -s 223.255.255.254/32 -d 143.137.74.0/23 -j DROP
sudo iptables -A INPUT -s 223.255.255.254/32 -d 187.94.97.36/30 -j DROP
sudo iptables -A INPUT -s 223.255.255.254/32 -d 143.137.72.112/28 -j DROP
sudo iptables -A INPUT -s 223.255.255.254/32 -d 45.160.88.0/22 -j DROP
sudo iptables -A INPUT -s 223.255.255.254/32 -d 187.94.99.72/30 -j DROP
sudo iptables -A INPUT -s 223.255.255.254/32 -d 189.125.26.0/30 -j DROP
sudo iptables -A INPUT -s 223.255.255.254/32 -d 200.186.168.60/30 -j DROP
sudo iptables -A INPUT -s 223.255.255.254/32 -d 143.137.72.104/29 -j DROP
sudo iptables -A INPUT -s 223.255.255.254/32 -d 189.125.21.216/30 -j DROP
sudo iptables -A INPUT -s 223.255.255.254/32 -d 191.37.240.0/21 -j DROP
sudo iptables -A INPUT -s 223.255.255.254/32 -d 143.137.72.64/27 -j DROP
sudo iptables -A INPUT -s 223.255.255.254/32 -d 161.22.56.0/21 -j DROP
sudo iptables -A INPUT -d 200.186.35.92/30 -j DROP
sudo iptables -A INPUT -d 177.53.240.136/29 -j DROP

sudo iptables -A OUTPUT -m state --state INVALID -j DROP
sudo iptables -A OUTPUT -p tcp --tcp-flags ALL FIN,URG,PSH -j DROP
sudo iptables -A OUTPUT -p tcp --tcp-flags ALL SYN,RST,ACK,FIN,URG -j DROP
sudo iptables -N flood
sudo iptables -A flood -m limit --limit 5/sec --limit-burst 10 -j RETURN
sudo iptables -A flood -j DROP
sudo iptables -A OUTPUT -p tcp --syn -j flood
sudo iptables -A OUTPUT -p tcp --tcp-flags SYN,ACK SYN,ACK -m conntrack --ctstate NEW -j DROP
sudo iptables -A OUTPUT -p tcp --tcp-flags FIN,ACK FIN,ACK -m conntrack --ctstate NEW -j DROP
sudo iptables -A OUTPUT -p tcp --tcp-flags ALL NONE -j DROP
sudo iptables -A OUTPUT -p tcp --tcp-flags ALL SYN,FIN,ACK -j DROP
sudo iptables -A OUTPUT -p tcp --tcp-flags ALL SYN,RST,ACK,FIN,URG -j DROP
sudo iptables -A OUTPUT -f -j DROP
sudo iptables -A OUTPUT -p tcp --tcp-flags ALL ALL -j DROP
sudo iptables -A OUTPUT -p tcp --tcp-flags ALL NONE -j DROP

sudo iptables -A OUTPUT -s 223.255.255.254/32 -d 170.245.12.0/22 -j DROP
sudo iptables -A OUTPUT -s 223.255.255.254/32 -d 189.90.51.52/30 -j DROP
sudo iptables -A OUTPUT -s 223.255.255.254/32 -d 143.137.72.128/25 -j DROP
sudo iptables -A OUTPUT -s 223.255.255.254/32 -d 200.186.135.236/30 -j DROP
sudo iptables -A OUTPUT -s 223.255.255.254/32 -d 177.53.240.132/30 -j DROP
sudo iptables -A OUTPUT -s 223.255.255.254/32 -d 177.53.240.192/26 -j DROP
sudo iptables -A OUTPUT -s 223.255.255.254/32 -d 200.186.191.76/30 -j DROP
sudo iptables -A OUTPUT -s 223.255.255.254/32 -d 200.186.168.56/30 -j DROP
sudo iptables -A OUTPUT -s 223.255.255.254/32 -d 191.37.248.0/22 -j DROP
sudo iptables -A OUTPUT -s 223.255.255.254/32 -d 189.90.56.48/30 -j DROP
sudo iptables -A OUTPUT -s 223.255.255.254/32 -d 189.125.21.220/30 -j DROP
sudo iptables -A OUTPUT -s 223.255.255.254/32 -d 177.53.240.0/25 -j DROP
sudo iptables -A OUTPUT -s 223.255.255.254/32 -d 177.53.240.144/28 -j DROP
sudo iptables -A OUTPUT -s 223.255.255.254/32 -d 45.237.108.0/22 -j DROP
sudo iptables -A OUTPUT -s 223.255.255.254/32 -d 177.53.244.0/22 -j DROP
sudo iptables -A OUTPUT -s 223.255.255.254/32 -d 45.166.204.0/22 -j DROP
sudo iptables -A OUTPUT -s 223.255.255.254/32 -d 143.137.72.0/26 -j DROP
sudo iptables -A OUTPUT -s 223.255.255.254/32 -d 177.53.242.0/23 -j DROP
sudo iptables -A OUTPUT -s 223.255.255.254/32 -d 177.53.241.0/24 -j DROP
sudo iptables -A OUTPUT -s 223.255.255.254/32 -d 189.125.8.52/30 -j DROP
sudo iptables -A OUTPUT -s 223.255.255.254/32 -d 177.53.240.160/27 -j DROP
sudo iptables -A OUTPUT -s 223.255.255.254/32 -d 143.137.72.96/29 -j DROP
sudo iptables -A OUTPUT -s 223.255.255.254/32 -d 143.137.73.0/24 -j DROP
sudo iptables -A OUTPUT -s 223.255.255.254/32 -d 143.137.74.0/23 -j DROP
sudo iptables -A OUTPUT -s 223.255.255.254/32 -d 187.94.97.36/30 -j DROP
sudo iptables -A OUTPUT -s 223.255.255.254/32 -d 143.137.72.112/28 -j DROP
sudo iptables -A OUTPUT -s 223.255.255.254/32 -d 45.160.88.0/22 -j DROP
sudo iptables -A OUTPUT -s 223.255.255.254/32 -d 187.94.99.72/30 -j DROP
sudo iptables -A OUTPUT -s 223.255.255.254/32 -d 189.125.26.0/30 -j DROP
sudo iptables -A OUTPUT -s 223.255.255.254/32 -d 200.186.168.60/30 -j DROP
sudo iptables -A OUTPUT -s 223.255.255.254/32 -d 143.137.72.104/29 -j DROP
sudo iptables -A OUTPUT -s 223.255.255.254/32 -d 189.125.21.216/30 -j DROP
sudo iptables -A OUTPUT -s 223.255.255.254/32 -d 191.37.240.0/21 -j DROP
sudo iptables -A OUTPUT -s 223.255.255.254/32 -d 143.137.72.64/27 -j DROP
sudo iptables -A OUTPUT -s 223.255.255.254/32 -d 161.22.56.0/21 -j DROP
sudo iptables -A OUTPUT -d 200.186.35.92/30 -j DROP
sudo iptables -A OUTPUT -d 177.53.240.136/29 -j DROP
sudo iptables -A OUTPUT -s 223.255.255.254/32 -o enp2s0 -p tcp -m tcp --dport 443 -j ACCEPT
sudo iptables -A OUTPUT -s 223.255.255.254/32 -d 1.1.1.1/32 -o enp2s0 -p udp -m udp --dport 53 -j ACCEPT
sudo iptables -A OUTPUT -s 223.255.255.254/32 -d 9.9.9.9/32 -o enp2s0 -p udp -m udp --dport 53 -j ACCEPT
sudo iptables -I INPUT -p udp -m multiport --sport 01:52,54:65535 -j DROP
sudo iptables -I INPUT -p tcp -m multiport --sport 01:79,81:442,444:65535 -j DROP
sudo iptables -A INPUT -m conntrack --ctstate RELATED,ESTABLISHED -j ACCEPT
sudo iptables -A INPUT -m conntrack --ctstate INVALID -j DROP
sudo iptables -A OUTPUT -m conntrack --ctstate RELATED,ESTABLISHED -j ACCEPT
sudo iptables -A INPUT -f -j DROP
sudo iptables -A OUTPUT -f -j DROP
sudo iptables -I INPUT -p icmp -j DROP
sudo iptables -I OUTPUT -p icmp -j DROP
sudo iptables -A INPUT -j DROP
sudo iptables -A OUTPUT -j DROP
}

packages() {
	sudo systemctl stop avahi-daemon && sudo systemctl disable avahi-daemon
	sudo systemctl stop ntpd && sudo systemctl disablee ntpd
	sudo systemctl stop nmb && sudo systemctl disable nmb
	sudo systemctl stop cups && sudo systemctl disable cups
	sudo systemctl stop cups-browsed && sudo systemctl disable cups-browsed
	sudo systemctl stop avahi-daemon && sudo systemctl disable avahi-daemon
	sudo pacman -Syy
	sudo pacman -Sy resolvconf
	sudo pacman -Sy florence
	sudo cp -r florence.desktop /home/$USER/florence.desktop
	sudo systemctl stop systemd-resolved &&	sudo systemctl disable systemd-resolved
	sudo killall avahi-daemon && sudo killall cups-browsed && sudo killall ntpd && sudo killall nmb
#	sudo pacman -Sy ufw gufw
}

tty() {
# Pick the default TTY used to open the graphical interface or user access
read -p "Input your number of default TTY: " tty_atual
# Loop through all ttys avaibles on >> /dev/tty*
	for tty in /dev/tty*
	do
	    # Extract the path complet to TTY 
	    tty_numero=${tty#/dev/tty}
	
	    # Disable all TTY encountered on folder
	    if [[ $tty_numero != $tty_atual ]]
	    then
	        sudo systemctl stop getty@$tty_numero.service
	        sudo systemctl disable getty@$tty_numero.service
	        echo "TTY $tty_numero disabled"
	    fi
		sudo rm -r /dev/tty*
	done
}

cleanlogs() {
# Remove all logs from the system
sudo rm -rf /var/log/*

# Clean temporary files
sudo rm -rf /tmp/*
sudo rm -rf /var/tmp/*

# Clean package cache and other unnecessary files
sudo apt-get autoclean -y
sudo apt-get autoremove -y

# Free up disk space by removing unnecessary packages
sudo apt-get clean -y

# Vacuum all logs to free up space
sudo journalctl --vacuum-size=1G

# Print disk space usage before and after cleanup
echo "Disk space usage before cleanup:"
df -h

# Clean up unused disk space
sudo fstrim -v /

# Print disk space usage after cleanup
echo "Disk space usage after cleanup:"
df -h

echo "Clean up complete!"
}

sysctl
iptables
tty
packages
#cleanlogs
