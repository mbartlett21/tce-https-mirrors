#!/bin/sh
tce-load -wil squashfs-tools

rm -rf build
sudo rm -rf /tmp/https-mirrors

mkdir build

sudo mkdir -p /tmp/https-mirrors/usr/local/https-mirrors
sudo mkdir -p /tmp/https-mirrors/usr/local/tce.installed
sudo mkdir -p /tmp/https-mirrors/usr/local/share/doc/https-mirrors

sudo cp COPYING                 /tmp/https-mirrors/usr/local/share/doc/https-mirrors/COPYING
sudo cp https-mirrors.patch     /tmp/https-mirrors/usr/local/https-mirrors/https-mirrors.patch
sudo cp https-mirrors.installed /tmp/https-mirrors/usr/local/tce.installed/https-mirrors

mksquashfs /tmp/https-mirrors build/https-mirrors.tcz

echo openssl.tcz >>build/https-mirrors.tcz.dep
echo ca-certificates.tcz >>build/https-mirrors.tcz.dep

if [ "$1" == "install" ]; then
	cp build/https-mirrors.tcz* -t /etc/sysconfig/tcedir/optional
	echo https-mirrors.tcz >>/etc/sysconfig/tcedir/onboot.lst
	tce-load -i https-mirrors.tcz
fi
