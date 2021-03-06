#!/bin/bash
echo "enable disk spin down"

cat > /etc/udev/rules.d/91-hdparm.rules <<EOF
ACTION=="add|change", KERNEL=="sd*", RUN+="/sbin/hdparm -B $DISK_POWERSAVE -S $DISK_SPINDOWN /dev/%k"
EOF
