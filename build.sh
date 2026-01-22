#!/bin/sh
tce-load -wil squashfs-tools

rm https-mirrors.tcz*

mksquashfs https-mirrors https-mirrors.tcz

echo openssl.tcz >>https-mirrors.tcz.dep
echo ca-certificates.tcz >>https-mirrors.tcz.dep

if [ "$1" == "install" ]; then
	cp https-mirrors.tcz* -t /etc/sysconfig/tcedir/optional
	echo https-mirrors.tcz >>/etc/sysconfig/tcedir/onboot.lst
	tce-load -i https-mirrors.tcz
fi
