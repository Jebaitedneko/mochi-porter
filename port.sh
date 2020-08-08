#!/bin/bash

updater=META-INF/com/google/android/updater-script

[ `unzip -Z1 $1 | grep compatibility.zip` ] && zip -d $1 compatibility.zip

unzip $1 $updater -d .
sed -i 's/assert(.*);/# Original Zip Script/g' $updater
sed -i 's/cust/vendor/g' $updater
echo -e "\nui_print(\"ROM ported to 10or G with MOCHI's autoporting script [TG: @mochi_wwww]\");" >> $updater
zip --update $1 $updater

mv $1 "MOCHI_PORTS_E_${1::-4}.zip" && rm -rf META-INF
