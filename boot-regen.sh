#!/bin/bash

unzip $1 boot.img -d .
mkdir -p boot

./bin/unpackbootimg -i boot.img -o boot && boot=boot/boot.img

[ $2 == '3' ] && cp bin/kud-3.18-2.1.2 $boot-zImage && kver=3.18.X
[ $2 == '4' ] && cp bin/kud-4.9-1.2 $boot-zImage && kver=4.9.X

sed -i 's/enforcing/permissive/g' $boot-cmdline
sed -i 's/$/ androidboot\.selinux\=\permissive/' $boot-cmdline
sed -i 's/$/ firmware_class\.path\=\/vendor\/firmware\_mnt\/image/' $boot-cmdline
cat $boot-cmdline | sed 's/ /\n/g' | sort -u | tr '\n' ' ' > boot/bcl && rm $boot-cmdline && mv boot/bcl $boot-cmdline

./bin/mkbootimg \
--kernel $boot-zImage \
--ramdisk $boot-ramdisk.gz \
--cmdline "$(cat $boot-cmdline)" \
--base $(cat $boot-base) \
--pagesize $(cat $boot-pagesize) \
-o boot_${1::-4}_${kver}.img

rm boot.img
rm -rf boot
