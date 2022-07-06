#!/bin/bash
bash <(curl -L https://raw.githubusercontent.com/v2fly/fhs-install-v2ray/master/install-release.sh)
cat >/usr/local/etc/v2ray/config.json<<EOF
{
    "inbound": {
        "streamSettings": {
            "network": "tcp", 
            "wsSettings": {
                "path": "/v2/", 
                "headers": {
                    "Host": "localhost"
                }
            }
        }, 
        "protocol": "vmess", 
        "port": 10086, 
        "settings": {
            "clients": [
                {
                    "alterId": 0, 
                    "id": "5d917123-4d5b-409c-9eee-92babe598149"
                }
            ]
        }
    }, 
    "log": {
        "loglevel": "warning", 
        "access": "/var/log/v2ray/access.log",
        "error": "/var/log/v2ray/error.log"
    }, 
    "routing": {
        "domainStrategy": "AsIs",
        "rules": [
            {
                "type": "field", 
                "ip": ["geoip:private"], 
                "outboundTag": "block"
            }
        ]
    },
    "outbounds": [
        {
            "protocol": "freedom",
            "tag": "direct"
        },
        {
            "protocol": "blackhole",
            "tag": "block"
        }
    ]
}
EOF
systemctl start v2ray
systemctl enable v2ray


