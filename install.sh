#!/bin/bash

#=== setup ===
cd
rm -rf /root/udp
mkdir -p /root/udp
rm -rf /etc/UDPCustom
mkdir -p /etc/UDPCustom
udp_dir='/etc/UDPCustom'
udp_file='/etc/UDPCustom/udp-custom'
sudo touch /etc/UDPCustom/udp-custom

sudo apt update -y
sudo apt upgrade -y
sudo apt install -y wget
sudo apt install -y curl
sudo apt install -y dos2unix

source <(curl -sSL 'https://raw.githubusercontent.com/prjkt-nv404/UDP-Custom-Installer-Manager/main/module/module')

time_reboot() {
  print_center -ama "${a92:-System/Server Reboot In} $1 ${a93:-Seconds}"
  REBOOT_TIMEOUT="$1"

  while [ $REBOOT_TIMEOUT -gt 0 ]; do
    print_center -ne "-$REBOOT_TIMEOUT-\r"
    sleep 1
    : $((REBOOT_TIMEOUT--))
  done
  rm /home/ubuntu/install.sh
  reboot
}

# Check Ubuntu version
if [ "$(lsb_release -rs)" = "8*|9*|10*|11*|16.04*|18.04*" ]; then
  clear
  print_center -ama -e "\e[1m\e[31m=====================================================\e[0m"
  print_center -ama -e "\e[1m\e[33m${a94:-this script is not compatible with your operating system}\e[0m"
  print_center -ama -e "\e[1m\e[33m ${a95:-Use Ubuntu 20 or higher}\e[0m"
  print_center -ama -e "\e[1m\e[31m=====================================================\e[0m"
  rm /home/ubuntu/install.sh
  exit 1
else
  clear
  echo ""
  print_center -ama "A Compatible OS/Environment Found"
  print_center -ama " > Installation begins...! <"
  sleep 3

    # [change to time UTC +0]
  echo ""
  echo "Change to time UTC +0"
  echo "for Africa/Accra"
  ln -fs /usr/share/zoneinfo/Africa/Accra /etc/localtime
  sleep 3

  # [+clean up+]
  rm -rf $udp_file
  rm -rf /etc/UDPCustom/udp-custom
  rm -rf /usr/bin/udp-request
  rm -rf /etc/limiter.sh
  rm -rf /etc/UDPCustom/limiter.sh
  rm -rf /etc/UDPCustom/module
  rm -rf /usr/bin/udp
  rm -rf /etc/UDPCustom/autostart.service
  rm -rf /etc/UDPCustom/autostart
  rm -rf /etc/autostart.service
  rm -rf /etc/autostart
  sudo systemctl stop autostart.service
  sudo systemctl stop udp-custom.service
  sudo systemctl stop udp-request.service

 # [+get files ⇣⇣⇣+]
  source <(curl -sSL 'https://raw.githubusercontent.com/prjkt-nv404/UDP-Custom-Installer-Manager/main/module/module') &>/dev/null
  wget -O /etc/UDPCustom/module 'https://raw.githubusercontent.com/prjkt-nv404/UDP-Custom-Installer-Manager/main/module/module' &>/dev/null
  chmod +x /etc/UDPCustom/module

  wget "https://raw.githubusercontent.com/prjkt-nv404/UDP-Custom-Installer-Manager/main/bin/udp-custom-linux-amd64" -O /root/udp/udp-custom &>/dev/null
  wget "https://raw.githubusercontent.com/prjkt-nv404/UDP-Custom-Installer-Manager/main/bin/udp-request-linux-amd64" -O /usr/bin/udp-request &>/dev/null
  chmod +x /root/udp/udp-custom
  chmod +x /usr/bin/udp-request

  wget -O /etc/limiter.sh 'https://raw.githubusercontent.com/prjkt-nv404/UDP-Custom-Installer-Manager/main/module/limiter.sh'
  chmod +x /etc/limiter.sh
  cp /etc/limiter.sh /etc/UDPCustom

  # [+auto-start+]
  wget -O /etc/autostart 'https://raw.githubusercontent.com/prjkt-nv404/UDP-Custom-Installer-Manager/main/module/autostart'
  chmod +x /etc/autostart
  cp /etc/autostart /etc/UDPCustom

  # [+udpgw+]
  wget -O /etc/udpgw 'https://raw.githubusercontent.com/prjkt-nv404/UDP-Custom-Installer-Manager/main/module/udpgw'
  chmod +x /etc/udpgw
  cp /etc/udpgw /bin

  # [+service+]
  wget -O /etc/autostart.service 'https://raw.githubusercontent.com/prjkt-nv404/UDP-Custom-Installer-Manager/main/config/autostart.service'
  wget -O /etc/udp-custom.service 'https://raw.githubusercontent.com/prjkt-nv404/UDP-Custom-Installer-Manager/main/config/udp-custom.service'
  wget -O /etc/udp-request.service 'https://raw.githubusercontent.com/prjkt-nv404/UDP-Custom-Installer-Manager/main/config/udp-request.service'

  cp /etc/autostart.service /etc/systemd/system/
  cp /etc/udp-custom.service /etc/systemd/system/
  cp /etc/udp-request.service /etc/systemd/system/

  sudo chmod 640 /etc/systemd/system/autostart.service

  sudo systemctl daemon-reload &>/dev/null
  sudo systemctl enable autostart &>/dev/null
  sudo systemctl start autostart &>/dev/null
  sudo systemctl enable udp-custom &>/dev/null
  sudo systemctl start udp-custom &>/dev/null
  sudo systemctl enable udp-request &>/dev/null
  sudo systemctl start udp-request &>/dev/null

  # [+config+]
  wget "https://raw.githubusercontent.com/prjkt-nv404/UDP-Custom-Installer-Manager/main/config/config.json" -O /root/udp/config.json &>/dev/null
  chmod 644 /root/udp/config.json

  # [+menu+]
  wget -O /usr/bin/udp 'https://raw.githubusercontent.com/prjkt-nv404/UDP-Custom-Installer-Manager/main/module/udp' 
  chmod +x /usr/bin/udp
  ufw disable &>/dev/null
  apt remove netfilter-persistent -y
  rm -rf /etc/UDPCustom/udp-custom
  print_center -ama "${a103:-setting up, please wait...}"
  sleep 3
  title "${a102:-Installation Successful}"
  print_center -ama "${a103:-Type the command \nudp\n to show menu}"
  msg -bar
  time_reboot 5
fi
