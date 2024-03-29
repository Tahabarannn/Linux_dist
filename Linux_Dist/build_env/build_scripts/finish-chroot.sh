#!/bin/bash

mkdir -pv /{boot,home,mnt,opt,srv}
mkdir -pv /etc/{opt,sysconfig}
mkdir -pv /lib/firmware
mkdir -pv /media/{floppy,cdrom}
mkdir -pv /usr/{,local/}{include,src}
mkdir -pv /usr/local/{bin,lib,sbin}
mkdir -pv /usr/{,local/}share/{color,dict,doc,info,locale,man}
mkdir -pv /usr/{,local/}share/{misc,terminfo,zoneinfo}
mkdir -pv /usr/{,local/}share/man/man{1..8}
mkdir -pv /var/{cache,local,log,mail,opt,spool}
mkdir -pv /var/lib/{color,misc,locate}

ln -sfv /run /var/run
ln -sfv /run/lock /var/lock

install -dv -m 0750 /root
install -dv -m 1777 /tmp /var/tmp

ln -sv /proc/self/mounts /etc/mtab

cat >/etc/hosts <<EOF
127.0.0.1  localhost lld
::1        localhost
EOF

touch /var/log/{btmp,lastlog,faillog,wtmp}
chgrp -v utmp /var/log/lastlog
chmod -v 664 /var/log/lastlog
chmod -v 600 /var/log/btmp

#Start building other packages
export DIST_ROOT=/dist
cd $DIST_ROOT/build_env

bash -e build_scripts/chr-gettext.sh gettext-0.22.tar.xz
bash -e build_scripts/chr-bison.sh bison-3.8.2.tar.xz
bash -e build_scripts/chr-perl.sh perl-5.38.0.tar.xz
bash -e build_scripts/chr-texinfo.sh texinfo-7.0.3.tar.xz
bash -e build_scripts/chr-util-linux.sh util-linux-2.39.1.tar.xz
bash -e build_scripts/python.sh Python-3.11.4.tar.xz

echo "Finished Chroot build!"

rm -rf /usr/share/{info,man,doc}/*
find /usr/{lib,libexec} -name \*.la -delete
rm -rf /tools

exit
