#!/bin/bash
updater=META-INF/com/google/android/updater-script
mkdir -p boot
[ `unzip -Z1 $2 | grep compatibility.zip` ] && zip -d $2 compatibility.zip
unzip $2 $updater boot.img -d .
sed -i 's/\"mido\"/getprop\(\"ro.product.device\"\)/g' $updater
sed -i 's/\"oxygen\"/getprop\(\"ro.product.device\"\)/g' $updater
sed -i 's/cust/vendor/g' $updater
sed -i 's/boot\.img/boot\_G\.img/g' $updater

unzip bin/core.zip -d tmp
mv tmp/mochi ./mochi
[ $1 == "m" ] && rm -rf mochi/oxygen | rm tmp/$updater | mv tmp/${updater}-mido tmp/$updater || rm -rf mochi/mido
cat tmp/$updater >> $updater
echo -e "\nui_print(\"ROM ported to 10or G with MOCHI's autoporting script [TG: @mochi_wwww]\");" >> $updater
zip -ur $2 mochi/*

zip --update $2 $updater
./bin/unpackbootimg-arm -i boot.img -o boot && boot=boot/boot.img
cp bin/kud-2.0 $boot-zImage
sed -i 's/enforcing/permissive/g' $boot-cmdline
sed -i 's/$/ androidboot\.selinux\=\permissive/' $boot-cmdline
sed -i 's/$/ firmware_class\.path\=\/vendor\/firmware\_mnt\/image/' $boot-cmdline
cat $boot-cmdline | sed 's/ /\n/g' | sort -u | tr '\n' ' ' > boot/bcl && rm $boot-cmdline && mv boot/bcl $boot-cmdline
./bin/mkbootimg-arm --kernel $boot-zImage --ramdisk $boot-ramdisk.gz --cmdline "$(cat $boot-cmdline)" --base $(cat $boot-base) --pagesize $(cat $boot-pagesize) -o boot_G.img
zip -ur $2 boot_G.img && rm boot.img && rm boot_G.img
zip -d $2 boot.img
mv $2 "MOCHI_PORTS_10or_G_${2::-4}_` [ $1 == "m" ] && echo "mido" || echo "oxygen" `_PORT.zip" && rm -rf META-INF && rm -rf boot && rm -rf tmp && rm -rf mochi
