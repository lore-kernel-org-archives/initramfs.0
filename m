From: Luca Berra <bluca-APJUtua8uzqonA0d6jMUrA@public.gmane.org>
Subject: Patches, Patches, Patches ...
Date: Tue, 29 Dec 2009 13:54:47 +0100
Message-ID: <20091229125447.GA5522@maude.comedia.it>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="G4iJoqBmSsgzjUCe"
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=comedia.it; h=
	user-agent:content-disposition:content-type:mime-version
	:message-id:subject:from:date:received:x-virus-scanned; s=200808
	; t=1262091287; bh=aQ/AZSCN/Qpa8gga4m5FQlXm15zZgltLL1NmcbsVxC0=;
	 b=ryPxbykpWMvGqiUv14JrksGHnq2ZRS0pPXUDMT9rulTr8r1TLDTLEZJ411cvx
	RkDwnrDQ7y5nUrYEFmOOyOhcRCYEoNfkRyJzhxND5kd1iygoIjjKUldanMTG/Zsi
	Htc8DFYgSCDUmI8ld3bpUsbz2pnWMYeWvBP2rRc+ckhPEo=
Content-Disposition: inline
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
To: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org


--G4iJoqBmSsgzjUCe
Content-Type: text/plain; charset=iso-8859-1; format=flowed
Content-Disposition: inline

Hello,
I am trying to integrate dracut into Mandriva, so far it looks good but
I had to do some modifications in order to have it working.
- dracut-003-kbd.patch: we have kbd data in /usr/lib, so this patch will
search for /lib/kbd and /usr/lib/kbd and use the existing one
- dracut-003-terminfo.patch: same applies to terminfo database
- dracut-003-kogz.patch: we use compressed kernel modules, this adds
support for those. I actually don't like very much the
uncompressing/nm/delete thinghy and I think we should put uncompressed
modules in the initrd, which is alreeady compressed, but I did not come
up with a clean patch yet
- dracut-003-selinux.patch: we dont' use selinux, so it makes no sense to
force load policy if selinux is not installed at all.

While testing it I also found some issue which I worked around:
- dracut-003-umount.patch: some modules call umount, but don't install it.
- dracut-003-rdshell.patch: for some unknown reason the emergency shell
starts with stderr closed, at first I even tought it was not working at
all, then I came up with this hack, which seems to work properly. I also
change the prompt to remind which step are we breaking to.

and added a feature:
- dracut-003-addmod.patch: this makes dracut load kernel module
   specified in add-drivers even if building an host-only mkinitrd, it is
useful in cases where we might change some storage drivers and still
don't want to build an enormous initrd (e.g. ahci/ata_piix)

latest is a wrapper around dracut with the syntax from mkinitrd, could
help transition to dracut.
mkinitrd-dracut.sh

patches are attached.

btw i am unable to git clone from sourceforge:
$ git clone -v git://dracut.git.sourceforge.net/gitroot/dracut
Initialized empty Git repository in /home/bluca/GIT/dracut/.git/
fatal: The remote end hung up unexpectedly

Regards,
L.

-- 
Luca Berra -- bluca-APJUtua8uzqonA0d6jMUrA@public.gmane.org
         Communication Media & Services S.r.l.
  /"\
  \ /     ASCII RIBBON CAMPAIGN
   X        AGAINST HTML MAIL
  / \

--G4iJoqBmSsgzjUCe
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: attachment; filename="dracut-003-addmod.patch"

diff -p -up dracut-003/dracut-functions.addmod dracut-003/dracut-functions
--- dracut-003/dracut-functions.addmod	2009-12-28 13:54:56.674196205 +0100
+++ dracut-003/dracut-functions	2009-12-28 21:49:33.163412583 +0100
@@ -499,7 +499,8 @@ instmods() {
 	        [[ -f $initdir/$1 ]] && { shift; continue; }
 		# If we are building a host-specific initramfs and this
 		# module is not already loaded, move on to the next one.
-		[[ $hostonly ]] && ! grep -q "${mod//-/_}" /proc/modules && {
+		[[ $hostonly ]] && ! grep -q "${mod//-/_}" /proc/modules && \
+	        ! echo $add_drivers | grep -qe "\<${mod}\>" &&	{
 		    shift; continue; 
 		}
 		# ok, load the module, all its dependencies, and any firmware

--G4iJoqBmSsgzjUCe
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: attachment; filename="dracut-003-kbd.patch"

diff -p -up dracut-003/modules.d/10redhat-i18n/install.kbd dracut-003/modules.d/10redhat-i18n/install
--- dracut-003/modules.d/10redhat-i18n/install.kbd	2009-11-27 15:25:46.000000000 +0100
+++ dracut-003/modules.d/10redhat-i18n/install	2009-12-29 11:00:52.655463682 +0100
@@ -3,7 +3,7 @@
 findkeymap () {
     local MAP=$1
     [[ ! -f $MAP ]] && \
-	MAP=$(find /lib/kbd/keymaps -type f -name $MAP -o -name $MAP.\* | head -n1)
+	MAP=$(find ${kbddir}/keymaps -type f -name $MAP -o -name $MAP.\* | head -n1)
     [[ " $KEYMAPS " = *" $MAP "* ]] && return
     KEYMAPS="$KEYMAPS $MAP"
     case $MAP in
@@ -13,7 +13,7 @@ findkeymap () {
     esac
 
     for INCL in $($cmd "^include " $MAP | cut -d' ' -f2 | tr -d '"'); do
-        for FN in $(find /lib/kbd/keymaps -type f -name $INCL\*); do
+        for FN in $(find ${kbddir}/keymaps -type f -name $INCL\*); do
             findkeymap $FN
         done
     done
@@ -27,7 +27,7 @@ install_local()
             KEYMAP=/etc/sysconfig/console/default.kmap
 	else
             . /etc/sysconfig/keyboard
-            [[ $KEYTABLE && -d /lib/kbd/keymaps ]] && KEYMAP="$KEYTABLE.map"
+            [[ $KEYTABLE && -d ${kbddir}/keymaps ]] && KEYMAP="$KEYTABLE.map"
 	fi
 	if [[ $KEYMAP ]]; then
             [ -f /etc/sysconfig/keyboard ] && inst /etc/sysconfig/keyboard
@@ -58,27 +58,31 @@ install_local()
 	[[ $SYSFONT ]] || SYSFONT=latarcyrheb-sun16
 	inst setfont
 
-	for FN in /lib/kbd/consolefonts/$SYSFONT.* ; do
+	for FN in ${kbddir}/consolefonts/$SYSFONT.* ; do
             inst "$FN"
             case $FN in
 		*.gz) gzip -d "$initdir$FN" ;;
 		*.bz2) bzip2 -d "$initdir$FN" ;;
             esac
 	done
-	[[ $SYSFONTACM ]] && inst /lib/kbd/consoletrans/$SYSFONTACM
-	[[ $UNIMAP ]] && inst /lib/kbd/unimaps/$UNIMAP
+	[[ $SYSFONTACM ]] && inst ${kbddir}/consoletrans/$SYSFONTACM
+	[[ $UNIMAP ]] && inst ${kbddir}/unimaps/$UNIMAP
     fi
 }
 
+for kbddir in /usr/lib/kbd /lib/kbd; do
+	[[ -d ${kbddir} ]] && break
+done
+
 if [[ $hostonly ]]; then 
     install_local
 else
-    for i in $(find /lib/kbd -type f -print); do
+    for i in $(find ${kbddir} -type f -print); do
 	dracut_install $i
     done
     # remove unnecessary files
-    rm -f "$initdir/lib/kbd/consoletrans/utflist" 2>/dev/null
-    find "$initdir/lib/kbd/" -name README\* -exec rm -f '{}' \;
+    rm -f "$initdir${kbddir}/consoletrans/utflist" 2>/dev/null
+    find "$initdir${kbddir}/" -name README\* -exec rm -f '{}' \;
     dracut_install gzip bzip2
 fi
 

--G4iJoqBmSsgzjUCe
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: attachment; filename="dracut-003-kogz.patch"

diff -p -up dracut-003/dracut-functions.kogz dracut-003/dracut-functions
--- dracut-003/dracut-functions.kogz	2009-11-27 15:25:46.000000000 +0100
+++ dracut-003/dracut-functions	2009-12-28 13:53:08.957798593 +0100
@@ -407,7 +407,7 @@ check_modules() {
 # $1 = full path to kernel module to install
 install_kmod_with_fw() {
     local modname=${1##*/} fwdir found
-    modname=${modname%.ko}
+    modname=${modname%.ko*}
     inst_simple "$1" "/lib/modules/$kernel/${1##*/lib/modules/$kernel/}" || \
 	return 0 # no need to go further if the module is already installed
     for fw in $(modinfo -k $kernel -F firmware $1 2>/dev/null); do
@@ -450,12 +450,21 @@ for_each_kmod_dep() {
 # This function returns the full filenames of modules that match $1
 filter_kernel_modules () (
     if ! [[ $hostonly ]]; then
-	filtercmd='find "$srcmods/kernel/drivers" -name "*.ko"'
+	filtercmd='find "$srcmods/kernel/drivers" -name "*.ko" -o -name "*.ko.gz"'
     else
 	filtercmd='cut -d " " -f 1 </proc/modules|xargs modinfo -F filename -k $kernel'
     fi
     for modname in $(eval $filtercmd); do
-	"$1" "$modname" && echo "$modname"
+        case $modname in
+            *.ko)
+                "$1" "$modname" && echo "$modname"
+                ;;
+            *.ko.gz)
+                gzip -dc "$modname" > $initdir/$$.ko
+                $1 $initdir/$$.ko && echo "$modname"
+                rm -f $initdir/$$.ko
+                ;;
+        esac
     done
 )
 
@@ -464,7 +473,7 @@ instmods() {
     [[ $no_kernel = yes ]] && return
     local mod mpargs modpath modname cmd
     while (($# > 0)); do
-	mod=${1%.ko}
+	mod=${1%.ko*}
 	case $mod in
 	    =*) # This introduces 2 incompatible meanings for =* arguments
                 # to instmods.  We need to decide which one to keep.

--G4iJoqBmSsgzjUCe
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: attachment; filename="dracut-003-rdshell.patch"

diff -p -up dracut-003/modules.d/99base/init.rdshell.orig dracut-003/modules.d/99base/init
--- dracut-003/modules.d/99base/init.rdshell.orig	2009-11-27 15:25:46.000000000 +0100
+++ dracut-003/modules.d/99base/init	2009-12-29 13:08:20.844275792 +0100
@@ -35,6 +35,12 @@ wait_for_loginit()
 
 emergency_shell()
 {
+    if [ $1 = "-n" ]; then
+        _rdshell_name=$2
+        shift 2 
+    else
+        _rdshell_name=dracut
+    fi
     wait_for_loginit
     echo ; echo
     echo $@
@@ -43,7 +49,9 @@ emergency_shell()
     if getarg rdshell || getarg rdbreak; then
         echo "Dropping to debug shell."
         echo
-        sh -i
+        export PS1="$_rdshell_name:\${PWD}# "
+        [ -e /.profile ] || echo "exec 0</dev/console 1>/dev/console 2>/dev/console" > /.profile
+        sh -i -l
     else
         echo "Boot has failed, sleeping forever."
         while :; do sleep 365d;done
@@ -101,7 +109,7 @@ UDEVVERSION=$(udevadm --version)
 source_conf /etc/conf.d
 
 # run scriptlets to parse the command line
-getarg 'rdbreak=cmdline' && emergency_shell "Break before cmdline"
+getarg 'rdbreak=cmdline' && emergency_shell -n cmdline "Break before cmdline"
 source_all cmdline
 
 [ -z "$root" ] && die "No or empty root= argument"
@@ -118,7 +126,7 @@ source_all cmdline
 } > /tmp/root.info
 
 # pre-udev scripts run before udev starts, and are run only once.
-getarg 'rdbreak=pre-udev' && emergency_shell "Break before pre-udev"
+getarg 'rdbreak=pre-udev' && emergency_shell -n pre-udev "Break before pre-udev"
 source_all pre-udev
 
 # start up udev and trigger cold plugs
@@ -135,13 +143,13 @@ fi
 getarg rdudevinfo && udevadm control $UDEV_LOG_PRIO_ARG=info
 getarg rdudevdebug && udevadm control $UDEV_LOG_PRIO_ARG=debug
 
-getarg 'rdbreak=pre-trigger' && emergency_shell "Break before pre-trigger"
+getarg 'rdbreak=pre-trigger' && emergency_shell -n pre-trigger "Break before pre-trigger"
 source_all pre-trigger
 
 # then the rest
 udevadm trigger $udevtriggeropts  >/dev/null 2>&1
 
-getarg 'rdbreak=initqueue' && emergency_shell "Break before initqueue"
+getarg 'rdbreak=initqueue' && emergency_shell -n initqueue "Break before initqueue"
 
 i=0
 while :; do
@@ -187,11 +195,11 @@ unset queuetriggered
 
 # pre-mount happens before we try to mount the root filesystem,
 # and happens once.
-getarg 'rdbreak=pre-mount' && emergency_shell "Break pre-mount"
+getarg 'rdbreak=pre-mount' && emergency_shell -n pre-mount "Break pre-mount"
 source_all pre-mount
 
 
-getarg 'rdbreak=mount' && emergency_shell "Break mount"
+getarg 'rdbreak=mount' && emergency_shell -n mount "Break mount"
 # mount scripts actually try to mount the root filesystem, and may
 # be sourced any number of times. As soon as one suceeds, no more are sourced.
 i=0
@@ -213,7 +221,7 @@ done
 } | vinfo
 
 # pre pivot scripts are sourced just before we switch over to the new root.
-getarg 'rdbreak=pre-pivot' && emergency_shell "Break pre-pivot"
+getarg 'rdbreak=pre-pivot' && emergency_shell -n pre-pivot "Break pre-pivot"
 source_all pre-pivot
 
 # by the time we get here, the root filesystem should be mounted.
@@ -228,7 +236,7 @@ done
     emergency_shell
 }
 
-getarg rdbreak && emergency_shell "Break before switch_root"
+getarg rdbreak && emergency_shell -n switch_root "Break before switch_root"
 
 # stop udev queue before killing it
 udevadm control --stop-exec-queue

--G4iJoqBmSsgzjUCe
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: attachment; filename="dracut-003-selinux.patch"

diff -p -up dracut-003/modules.d/99base/install.selinux dracut-003/modules.d/99base/install
--- dracut-003/modules.d/99base/install.selinux	2009-11-27 15:25:46.000000000 +0100
+++ dracut-003/modules.d/99base/install	2009-12-29 12:01:56.033557750 +0100
@@ -23,5 +23,7 @@ fi
 inst "$moddir/dracut-lib.sh" "/lib/dracut-lib.sh"
 inst_hook cmdline 10 "$moddir/parse-root-opts.sh"
 inst_hook cmdline 20 "$moddir/parse-blacklist.sh"
-inst_hook pre-pivot 50 "$moddir/selinux-loadpolicy.sh"
+if [ -x "/usr/sbin/load_policy" -o -x "/sbin/load_policy" ]; then
+	inst_hook pre-pivot 50 "$moddir/selinux-loadpolicy.sh"
+fi
 mkdir -p "${initdir}/var/run"

--G4iJoqBmSsgzjUCe
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: attachment; filename="dracut-003-terminfo.patch"

diff -p -up dracut-003/modules.d/95terminfo/install.terminfo dracut-003/modules.d/95terminfo/install
--- dracut-003/modules.d/95terminfo/install.terminfo	2009-12-29 11:10:16.287854710 +0100
+++ dracut-003/modules.d/95terminfo/install	2009-12-29 11:10:14.294156785 +0100
@@ -1,8 +1,8 @@
 #!/bin/bash
 # terminfo bits make things work better if you fall into interactive mode
-TERMINFODIR="/lib/terminfo"
+for TERMINFODIR in /lib/terminfo /etc/terminfo /usr/share/terminfo; do
+	[ -d ${TERMINFODIR} ] && break
+done
 
-[ ! -d ${TERMINFODIR} -a -d "/etc/terminfo" ] && \
-	TERMINFODIR="/etc/terminfo"
-
-dracut_install $(find ${TERMINFODIR} -type f)
+[ -d ${TERMINFODIR} ] && \
+	dracut_install $(find ${TERMINFODIR} -type f)

--G4iJoqBmSsgzjUCe
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: attachment; filename="dracut-003-umount.patch"

diff -p -up dracut-003/modules.d/01fips/install.umount dracut-003/modules.d/01fips/install
--- dracut-003/modules.d/01fips/install.umount	2009-11-27 15:25:46.000000000 +0100
+++ dracut-003/modules.d/01fips/install	2009-12-29 11:36:04.542497926 +0100
@@ -1,7 +1,7 @@
 #!/bin/bash
 
 inst_hook pre-trigger 01 "$moddir/fips.sh"
-dracut_install sha512hmac rmmod insmod mount uname
+dracut_install sha512hmac rmmod insmod mount uname umount
 
 libdir="lib"
 if ldd $(find_binary sha512hmac) |grep -q /lib64/libc; then
diff -p -up dracut-003/modules.d/95rootfs-block/install.umount dracut-003/modules.d/95rootfs-block/install
--- dracut-003/modules.d/95rootfs-block/install.umount	2009-11-27 15:25:46.000000000 +0100
+++ dracut-003/modules.d/95rootfs-block/install	2009-12-29 11:34:52.025654159 +0100
@@ -1,4 +1,5 @@
 #!/bin/sh
+dracut_install umount
 inst_hook cmdline 95 "$moddir/parse-block.sh"
 inst_hook pre-udev 30 "$moddir/block-genrules.sh"
 inst_hook mount 99 "$moddir/mount-root.sh"

--G4iJoqBmSsgzjUCe
Content-Type: application/x-sh
Content-Disposition: attachment; filename="mkinitrd-dracut.sh"
Content-Transfer-Encoding: quoted-printable

#!/bin/bash --norc=0A=0Aerror() {=0A    local NONL=3D""=0A    if [ "$1" =3D=
=3D "-n" ]; then=0A        NONL=3D"-n"=0A        shift=0A    fi=0A    echo =
$NONL "$@" > /dev/stderr=0A}=0A=0Ausage () {=0A    if [ "$1" =3D=3D "-n" ];=
 then=0A        cmd=3Decho=0A    else=0A        cmd=3Derror=0A    fi=0A=0A =
   $cmd "usage: `basename $0` [--version] [--help] [-v] [-f] [--preload <mo=
dule>]"=0A    $cmd "       [--force-scsi-probe | --omit-scsi-modules]"=0A  =
  $cmd "       [--omit-ide-modules]"=0A    $cmd "       [--image-version] [=
--force-raid-probe | --omit-raid-modules]"=0A    $cmd "       [--with=3D<mo=
dule>] [--force-lvm-probe | --omit-lvm-modules]"=0A    $cmd "       [--buil=
tin=3D<module>] [--omit-dmraid] [--net-dev=3D<interface>]"=0A    $cmd "    =
   [--fstab=3D<fstab>] [--nocompress] <initrd-image> <kernel-version>"=0A  =
  $cmd "       [--dsdt[=3D<dsdt.aml>]] [--bootchart]]"=0A    $cmd ""=0A    =
$cmd "       (ex: `basename $0` /boot/initrd-$(uname -r).img $(uname -r))"=
=0A=0A    if [ "$1" =3D=3D "-n" ]; then=0A        exit 0=0A    else=0A     =
   exit 1=0A    fi=0A}=0A=0A=0Awhile [ $# -gt 0 ]; do=0A    case $1 in=0A  =
      --fstab*) ;;=0A        --with-usb*)=0A            if [ "$1" !=3D "${1=
##--with-usb=3D}" ]; then=0A                usbmodule=3D${1##--with-usb=3D}=
=0A            else=0A                usbmodule=3D"usb-storage"=0A         =
   fi=0A            basicmodules=3D"$basicmodules $usbmodule"=0A           =
 unset usbmodule=0A            ;;=0A        --without-usb) ;;=0A        --w=
ith-avail*)=0A            if [ "$1" !=3D "${1##--with-avail=3D}" ]; then=0A=
                modname=3D${1##--with-avail=3D}=0A            else=0A      =
          modname=3D$2=0A                shift=0A            fi=0A=0A      =
      basicmodules=3D"$basicmodules $modname"=0A            ;;=0A        --=
without*) ;;=0A        --with*)=0A            if [ "$1" !=3D "${1##--with=
=3D}" ]; then=0A                modname=3D${1##--with=3D}=0A            els=
e=0A                modname=3D$2=0A                shift=0A            fi=
=0A=0A            basicmodules=3D"$basicmodules $modname"=0A            ;;=
=0A        --builtin*) ;;=0A        --version)=0A            echo "mkinitrd=
: dracut compatibility wrapper"=0A            exit 0=0A            ;;=0A   =
     -v|--verbose)=0A            dracut_args=3D"${dracut_args} -v"=0A      =
      ;;=0A        --nocompress) ;;=0A        --ifneeded) ;;=0A        -f)=
=0A            dracut_args=3D"${dracut_args} -f"=0A            ;;=0A       =
 --preload*)=0A            if [ "$1" !=3D "${1##--preload=3D}" ]; then=0A  =
              modname=3D${1##--preload=3D}=0A            else=0A           =
     modname=3D$2=0A                shift=0A            fi=0A            ba=
sicmodules=3D"$basicmodules $modname"=0A            ;;=0A        --omit-scs=
i-modules) ;;=0A        --omit-ide-modules) ;;=0A        --omit-raid-module=
s) ;;=0A        --omit-lvm-modules) ;;=0A        --omit-dmraid) ;;=0A      =
  --image-version)=0A            img_vers=3Dyes=0A            ;;=0A        =
--allow-missing) ;;=0A        --net-dev*) ;;=0A        --noresume) ;;=0A	--=
rootdev*) ;;=0A	--thawdev*) ;;=0A	--rootfs*)=0A            if [ "$1" !=3D "=
${1##--rootfs=3D}" ]; then=0A                rootfs=3D"${1##--rootfs=3D}"=
=0A            else=0A                rootfs=3D"$2"=0A                shift=
=0A            fi=0A	    dracut_args=3D"${dracut_args} --filesystems $rootf=
s"=0A	    ;;=0A	--rootopts*) ;;=0A	--root*) ;;=0A	--loopdev*) ;;=0A	--loopf=
s*) ;;=0A	--loopopts*) ;;=0A	--looppath*) ;;=0A	--dsdt*) ;;=0A        --hel=
p)=0A            usage -n=0A            ;;=0A        --bootchart) ;;=0A    =
    *)=0A            if [ -z "$target" ]; then=0A                target=3D$=
1=0A            elif [ -z "$kernel" ]; then=0A                kernel=3D$1=
=0A            else=0A                usage=0A            fi=0A            =
;;=0A    esac=0A=0A    shift=0Adone=0A=0Aif [ -z "$target" -o -z "$kernel" =
]; then=0A    usage=0Afi=0A=0Aif [ -n "$img_vers" ]; then=0A    target=3D"$=
target-$kernel"=0Afi=0A=0Aif [ -n "$basicmodules" ]; then=0A	dracut -H $dra=
cut_args --add-drivers "$basicmodules" "$target" "$kernel"=0Aelse=0A	dracut=
 -H $dracut_args "$target" "$kernel"=0Afi=0A=0A# vim:ts=3D8:sw=3D4:sts=3D4:=
et=0A
--G4iJoqBmSsgzjUCe--
