#!/bin/bash

sudo apt update
sudo apt upgrade -y

sudo apt install dnsmasq
sudo systemctl enable dnsmasq
sudo systemctl start dnsmasq

sudo echo 'address=/nepviewer.net/192.168.12.1' >> /etc/dnsmasq.conf
sudo echo 'address=/solar.info/192.168.12.1' >> /etc/dnsmasq.conf
sudo echo 'port=53' >> /etc/dnsmasq.conf

sudo apt install -y libgtk-3-dev build-essential gcc g++ pkg-config make hostapd libqrencode-dev libpng-dev
git clone https://github.com/lakinduakash/linux-wifi-hotspot
sudo make install
sudo rm -rf linux-wifi-hotspot
sudo apt remove -y libgtk-3-dev build-essential gcc g++ pkg-config make libqrencode-dev libpng-dev
sudo apt autoremove -y
sudo apt clean

sudo echo "nameserver 127.0.0.1" >> /etc/resolv.conf
sudo chattr +i /etc/resolv.conf

sudo mv www /var/
sudo apt install python3-waitress
sudo apt install nginx
sudo mv nginx.conf /etc/nginx/nginx.conf

sudo systemctl enable nginx
sudo pkill nginx
sudo systemctl start nginx
sudo chown -R pi:pi /var/www

sudo mv solar_web.service  /etc/systemd/system/
sudo systemctl daemon-reload
sudo systemctl enable solar_web
sudo systemctl start solar_web

sudo apt install ufw
sudo ufw allow 22
sudo ufw allow 80
sudo ufw allow 53
sudo ufw enable

sudo mv ap_setup.sh /root/
sudo chmod +x /root/ap_setup.sh
sudo mv ap_setup.service /etc/systemd/system/
sudo systemctl daemon-reload
sudo systemctl enable ap_setup.service

sudo sed 's/pi ALL=(ALL) NOPASSWD: ALL/pi ALL=(ALL) PASSWD: ALL/g' -i /etc/sudoers.d/010_pi-nopasswd

sudo reboot
