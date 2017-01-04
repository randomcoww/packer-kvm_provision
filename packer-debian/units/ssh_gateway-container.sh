cat > /etc/systemd/system/ssh_gateway-container.service <<EOF
[Unit]
Description=ssh_gateway-container
After=docker.service
BindsTo=docker.service

[Service]
TimeoutStartSec=0
Restart=on-failure
RestartSec=20
ExecStartPre=-/usr/bin/docker stop ssh_gateway
ExecStartPre=-/usr/bin/docker kill ssh_gateway
ExecStartPre=-/usr/bin/docker rm ssh_gateway
ExecStartPre=-/usr/bin/docker pull randomcoww/ssh_gateway
ExecStart=/usr/bin/docker run --rm --name ssh_gateway --net=brlan --ip 192.168.63.252 -v /etc/resolv.conf:/etc/resolv.conf:ro randomcoww/ssh_gateway -u randomcoww -r https://github.com/randomcoww/ssh-gateway_user_config.git -b master
ExecStartPost=-/bin/sh -c '/usr/bin/docker rmi \$(/usr/bin/docker images -qf dangling=true)'
ExecStop=/usr/bin/docker stop ssh_gateway

[Install]
WantedBy=multi-user.target
EOF
systemctl enable ssh_gateway-container.service