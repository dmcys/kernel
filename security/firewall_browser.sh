#!/bin/bash
browserfirewall() {
# Verify if the user is ROOT
if [[ $EUID -ne 0 ]]; then
   echo "Este script precisa ser executado como root" 
   exit 1
fi

# Set the port that go open
porta=443/tcp

# Loop
while true; do

    # Verify if have one browser opened
    if pgrep -x waterfox || pgrep -x librewolf || pgrep -x firefox || pgrep -x firefox-esr > /dev/null; then

        # Open the firewall rule
        if ! iptables -C OUTPUT -p tcp --dport $porta -j ACCEPT > /dev/null 2>&1; then
            iptables -A OUTPUT -p tcp --dport $porta -j ACCEPT
            echo "Port $porta opened"
        fi

    else

        # Close the firewall port after the browser close
        if iptables -C OUTPUT -p tcp --dport $porta -j ACCEPT > /dev/null 2>&1; then
            iptables -D OUTPUT -p tcp --dport $porta -j ACCEPT
            echo "Port $porta closed"
        fi

    fi

    # Wait one second to verify again
    sleep 1

done
}
browserfirewall
