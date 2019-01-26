#!/bin/bash

##Pull variables from github
wget -nc https://raw.githubusercontent.com/CHBMB/Unraid-DVB/master/build_scripts/variables.sh
. "$(dirname "$(readlink -f ${BASH_SOURCE[0]})")"/variables.sh



##Make new bzmodules and bzfirmware - not overwriting existing
mksquashfs /lib/modules/$(uname -r)/ $D/$VERSION/stock/bzmodules-new -keep-as-directory -noappend
mksquashfs /lib/firmware $D/$VERSION/stock/bzfirmware-new -noappend

#Package Up new bzimage
cp -f $D/kernel/arch/x86/boot/bzImage $D/$VERSION/stock/bzimage-new

##Make backup of /lib/firmware & /lib/modules
mkdir -p $D/backup/modules
cp -r /lib/modules/ $D/backup/
mkdir -p $D/backup/firmware
cp -r /lib/firmware/ $D/backup/

##Calculate md5 on new bzimage, bzfirmware & bzmodules
cd $D/$VERSION/stock/
md5sum bzimage-new > bzimage-new.md5
md5sum bzmodules-new > bzmodules-new.md5
md5sum bzfirmware-new > bzfirmware-new.md5

##Return to original directory
cd $D
