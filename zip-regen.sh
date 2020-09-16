#!/bin/bash

updater=META-INF/com/google/android/updater-script
rm -rf aio_patchers/*

main() {
[[ $1 == "m" ]] \
&& model=mido \
&& mv tmp/${updater}-mido tmp/$updater \
&& rm tmp/${updater}-* \
|| rm -rf tmp/mochi/mido

[[ $1 == "o" ]] \
&& model=oxygen \
&& mv tmp/${updater}-oxygen tmp/$updater \
&& rm tmp/${updater}-* \
|| rm -rf tmp/mochi/oxygen

[[ $1 == "v" ]] \
&& model=vince \
&& mv tmp/${updater}-vince tmp/$updater \
&& rm tmp/${updater}-* \
|| rm -rf tmp/mochi/vince
}

zip_regen() {
unzip bin/core.zip -d tmp
main $1
7z a aio_patchers/aio-${model}.zip ./tmp/*
rm -rf tmp
}

zip_regen_q() {
unzip bin/core.zip -d tmp
main $1
sed -i '/remosaic/d' tmp/$updater
sed -i '/camera-common/d' tmp/$updater
rm -rf tmp/mochi/camera-common
7z a aio_patchers/aio-${model}_a10.zip ./tmp/*
rm -rf tmp
}

zip_regen m
zip_regen o
zip_regen v

# zip_regen_q m
# zip_regen_q o
# zip_regen_q v
