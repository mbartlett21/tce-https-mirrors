#!/bin/sh
tce-load -wil squashfs-tools

rm https-mirrors.tcz*
sudo rm -rf /tmp/https-mirrors

sudo mkdir -p /tmp/https-mirrors/usr/local/https-mirrors
sudo mkdir -p /tmp/https-mirrors/usr/local/tce.installed

sudo cp https-mirrors.patch     /tmp/https-mirrors/usr/local/https-mirrors/https-mirrors.patch
sudo cp https-mirrors.installed /tmp/https-mirrors/usr/local/tce.installed/https-mirrors

mksquashfs /tmp/https-mirrors https-mirrors.tcz

echo openssl.tcz >>https-mirrors.tcz.dep
echo ca-certificates.tcz >>https-mirrors.tcz.dep

if [ "$1" == "install" ]; then
	cp https-mirrors.tcz* -t /etc/sysconfig/tcedir/optional
	echo https-mirrors.tcz >>/etc/sysconfig/tcedir/onboot.lst
	tce-load -i https-mirrors.tcz
fi
