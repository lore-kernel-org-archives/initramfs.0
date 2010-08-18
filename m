From: Amadeusz =?UTF-8?B?xbtvxYJub3dza2k=?= <aidecoe-2qtfh70TtYba5EbDDlwbIw@public.gmane.org>
Subject: [PATCH 1/2] use 'type' built-in instead of external cmd 'which' in
 every Bash script
Date: Wed, 18 Aug 2010 17:29:44 +0200
Message-ID: <20100818172944.3244c1e0@aidecoe.name>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=PGP-SHA1;
 boundary="Sig_//XNKcFSFvfD.hebZ+nFAcR3"; protocol="application/pgp-signature"
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
To: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

--Sig_//XNKcFSFvfD.hebZ+nFAcR3
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable


---
 dracut                            |    2 +-
 dracut.spec                       |    1 -
 modules.d/10rpmversion/install    |    4 ++--
 modules.d/40network/check         |    9 ++-------
 modules.d/40network/install       |    2 +-
 modules.d/50plymouth/check        |    2 +-
 modules.d/60xen/check             |    2 +-
 modules.d/60xen/install           |    2 +-
 modules.d/90btrfs/check           |    2 +-
 modules.d/90crypt/check           |    2 +-
 modules.d/90dmraid/check          |    2 +-
 modules.d/90dmraid/install        |    2 +-
 modules.d/90dmsquash-live/install |    2 +-
 modules.d/90lvm/check             |    2 +-
 modules.d/90lvm/install           |    2 +-
 modules.d/90mdraid/check          |    2 +-
 modules.d/90multipath/check       |    4 ++--
 modules.d/90multipath/install     |    2 +-
 modules.d/95iscsi/check           |    2 +-
 modules.d/95nbd/check             |    2 +-
 modules.d/95nfs/check             |    4 ++--
 modules.d/95nfs/install           |    8 ++++----
 modules.d/98syslog/install        |    8 ++++----
 modules.d/99base/install          |    2 +-
 test/TEST-20-NFS/test.sh          |    8 ++++----
 test/TEST-30-ISCSI/test.sh        |    2 +-
 test/TEST-40-NBD/test.sh          |    2 +-
 test/TEST-50-MULTINIC/test.sh     |    8 ++++----
 28 files changed, 43 insertions(+), 49 deletions(-)

diff --git a/dracut b/dracut
index a50e14a..fb284fb 100755
--- a/dracut
+++ b/dracut
@@ -300,7 +300,7 @@ ldconfig -r "$initdir" || [[ $(id -u) !=3D "0" ]] && di=
nfo "ldconfig might need ui
 # strip binaries=20
 if [[ $do_strip =3D yes ]] ; then
     for p in strip grep find; do=20
-	if ! which $p >/dev/null 2>&1; then
+	if ! type -P $p >/dev/null; then
 	    derror "Could not find '$p'. You should run $0 with '--nostrip'."
 	    do_strip=3Dno
 	fi
diff --git a/dracut.spec b/dracut.spec
index 2cd570a..b0c248c 100644
--- a/dracut.spec
+++ b/dracut.spec
@@ -61,7 +61,6 @@ Requires: sed
 Requires: tar
 Requires: udev
 Requires: util-linux-ng >=3D 2.16
-Requires: which
=20
 %if ! 0%{?with_switch_root}
 BuildArch: noarch
diff --git a/modules.d/10rpmversion/install b/modules.d/10rpmversion/install
index 2349674..1fd0005 100755
--- a/modules.d/10rpmversion/install
+++ b/modules.d/10rpmversion/install
@@ -4,8 +4,8 @@ if [ -e "$moddir/dracut-version" ]; then
     dracut_rpm_version=3D$(cat "$moddir/dracut-version")
     inst "$moddir/dracut-version" /$dracut_rpm_version
 else
-    if rpm -qf $(which $0) &>/dev/null; then
-        dracut_rpm_version=3D$(rpm -qf --qf '%{name}-%{version}-%{release}=
\n' $(which $0) | { ver=3D"";while read line;do ver=3D$line;done;echo $ver;=
} )
+    if rpm -qf $(type -P $0) &>/dev/null; then
+        dracut_rpm_version=3D$(rpm -qf --qf '%{name}-%{version}-%{release}=
\n' $(type -P $0) | { ver=3D"";while read line;do ver=3D$line;done;echo $ve=
r;} )
         echo $dracut_rpm_version > $initdir/$dracut_rpm_version
     fi
 fi
diff --git a/modules.d/40network/check b/modules.d/40network/check
index 48b7f12..4e2a5fd 100755
--- a/modules.d/40network/check
+++ b/modules.d/40network/check
@@ -8,20 +8,15 @@ fi
 . $dracutfunctions
=20
 for program in ip arping; do=20
-  which $program >/dev/null 2>&1
-  if [ $? -ne 0 ]; then
+  if ! type -P $program >/dev/null; then
     dwarning "Could not find program \"$program\" required by network."=20
     exit 1
   fi
 done
 for program in dhclient brctl; do
-  which $program >/dev/null 2>&1
-  if [ $? -ne 0 ]; then
+  if ! type -P $program >/dev/null; then
     dwarning "Could not find program \"$program\" it might be required by =
network."=20
   fi
 done
=20
-
-
 exit 255
-
diff --git a/modules.d/40network/install b/modules.d/40network/install
index 398d4e4..d8e0399 100755
--- a/modules.d/40network/install
+++ b/modules.d/40network/install
@@ -12,7 +12,7 @@ inst_hook cmdline 98 "$moddir/parse-bridge.sh"
 inst_hook cmdline 99 "$moddir/parse-ifname.sh"
 inst_hook pre-pivot 10 "$moddir/kill-dhclient.sh"
=20
-if ldd $(which sh) | grep -q lib64; then
+if ldd $(type -P sh) | grep -q lib64; then
     LIBDIR=3D"/lib64"
 else
     LIBDIR=3D"/lib"
diff --git a/modules.d/50plymouth/check b/modules.d/50plymouth/check
index ceb26a7..40f2016 100755
--- a/modules.d/50plymouth/check
+++ b/modules.d/50plymouth/check
@@ -1,3 +1,3 @@
 #!/bin/bash
-[[ $1 =3D -d ]] && which cryptsetup &>/dev/null && echo crypt
+[[ $1 =3D -d ]] && type -P cryptsetup >/dev/null && echo crypt
 [[ -x /sbin/plymouthd && -x /bin/plymouth && -x /usr/sbin/plymouth-set-def=
ault-theme ]]
diff --git a/modules.d/60xen/check b/modules.d/60xen/check
index f155582..49d5435 100755
--- a/modules.d/60xen/check
+++ b/modules.d/60xen/check
@@ -1,7 +1,7 @@
 #!/bin/bash
=20
 # No Xen-detect? Boo!!
-XENDETECT=3D$(which xen-detect 2>/dev/null)
+XENDETECT=3D$(type -P xen-detect)
 [ -z "$XENDETECT" ] && [ -d "/usr/lib/xen-default" ] && XENDETECT=3D"/usr/=
lib/xen-default/bin/xen-detect"
 [ -z "$XENDETECT" ] && exit 1
=20
diff --git a/modules.d/60xen/install b/modules.d/60xen/install
index 89065b5..22f5329 100755
--- a/modules.d/60xen/install
+++ b/modules.d/60xen/install
@@ -1,5 +1,5 @@
 #!/bin/bash
-XENDETECT=3D$(which xen-detect)
+XENDETECT=3D$(type -P xen-detect)
 [ -z "$XENDETECT" ] && [ -d "/usr/lib/xen-default" ] && XENDETECT=3D"/usr/=
lib/xen-default/bin/xen-detect"
 inst $XENDETECT /sbin/xen-detect
 inst_hook pre-udev 40 "$moddir/xen-pre-udev.sh"
diff --git a/modules.d/90btrfs/check b/modules.d/90btrfs/check
index 99aa712..c562cb8 100755
--- a/modules.d/90btrfs/check
+++ b/modules.d/90btrfs/check
@@ -5,7 +5,7 @@
=20
 # if we don't have btrfs (btrfsctl) installed on the host system,
 # no point in trying to support it in the initramfs.
-which btrfsctl >/dev/null 2>&1 || exit 1
+type -P btrfsctl >/dev/null || exit 1
=20
 . $dracutfunctions
 [[ $debug ]] && set -x
diff --git a/modules.d/90crypt/check b/modules.d/90crypt/check
index a34a05e..a1a5453 100755
--- a/modules.d/90crypt/check
+++ b/modules.d/90crypt/check
@@ -1,7 +1,7 @@
 #!/bin/bash
=20
 # if cryptsetup is not installed, then we cannot support encrypted devices.
-which cryptsetup >/dev/null 2>&1 || exit 1
+type -P cryptsetup >/dev/null || exit 1
=20
 [ "$1" =3D "-d" ] && echo dm
=20
diff --git a/modules.d/90dmraid/check b/modules.d/90dmraid/check
index 147b7fa..b93de09 100755
--- a/modules.d/90dmraid/check
+++ b/modules.d/90dmraid/check
@@ -5,7 +5,7 @@
=20
 # if we don't have dmraid installed on the host system, no point
 # in trying to support it in the initramfs.
-which dmraid >/dev/null 2>&1 || exit 1
+type -P dmraid >/dev/null || exit 1
=20
 . $dracutfunctions
 [[ $debug ]] && set -x
diff --git a/modules.d/90dmraid/install b/modules.d/90dmraid/install
index a016e4d..1a63ad7 100755
--- a/modules.d/90dmraid/install
+++ b/modules.d/90dmraid/install
@@ -3,7 +3,7 @@ dracut_install dmraid partx kpartx
=20
 inst  dmeventd
=20
-if ldd $(which dmraid) | grep -q lib64; then
+if ldd $(type -P dmraid) | grep -q lib64; then
     LIBDIR=3D"/lib64"
 else
     LIBDIR=3D"/lib"
diff --git a/modules.d/90dmsquash-live/install b/modules.d/90dmsquash-live/=
install
index ad1d29c..daa4c45 100755
--- a/modules.d/90dmsquash-live/install
+++ b/modules.d/90dmsquash-live/install
@@ -14,7 +14,7 @@ else
 fi
=20
 inst blockdev
-which checkisomd5 >/dev/null 2>&1 && inst checkisomd5
+type -P checkisomd5 >/dev/null && inst checkisomd5
 inst_hook cmdline 30 "$moddir/parse-dmsquash-live.sh"
 inst_hook pre-udev 30 "$moddir/dmsquash-live-genrules.sh"
 inst_hook pre-udev 30 "$moddir/dmsquash-liveiso-genrules.sh"
diff --git a/modules.d/90lvm/check b/modules.d/90lvm/check
index 20f21e8..26f39cb 100755
--- a/modules.d/90lvm/check
+++ b/modules.d/90lvm/check
@@ -4,7 +4,7 @@
 [ "$1" =3D "-d" ] && echo dm
=20
 # No point trying to support lvm if the binaries are missing
-which lvm >/dev/null 2>&1 || exit 1
+type -P lvm >/dev/null || exit 1
=20
 . $dracutfunctions
 [[ $debug ]] && set -x
diff --git a/modules.d/90lvm/install b/modules.d/90lvm/install
index 3e20866..9eba6e8 100755
--- a/modules.d/90lvm/install
+++ b/modules.d/90lvm/install
@@ -18,7 +18,7 @@ inst "$moddir/lvm_scan.sh" /sbin/lvm_scan
 inst_hook cmdline 30 "$moddir/parse-lvm.sh"
=20
=20
-if ldd $(which lvm) | grep -q lib64; then
+if ldd $(type -P lvm) | grep -q lib64; then
     LIBDIR=3D"/lib64"
 else
     LIBDIR=3D"/lib"
diff --git a/modules.d/90mdraid/check b/modules.d/90mdraid/check
index cad3d0b..77aa1f5 100755
--- a/modules.d/90mdraid/check
+++ b/modules.d/90mdraid/check
@@ -1,7 +1,7 @@
 #!/bin/bash
=20
 # No mdadm?  No mdraid support.
-which mdadm >/dev/null 2>&1 || exit 1
+type -P mdadm >/dev/null || exit 1
=20
 . $dracutfunctions
 [[ $debug ]] && set -x
diff --git a/modules.d/90multipath/check b/modules.d/90multipath/check
index b1834b5..511c5d5 100755
--- a/modules.d/90multipath/check
+++ b/modules.d/90multipath/check
@@ -1,7 +1,7 @@
 #!/bin/bash
=20
 # if there's no multipath binary, no go.
-which multipath >/dev/null 2>&1 || exit 1
+type -P multipath >/dev/null || exit 1
=20
 [[ $1 =3D -d ]] && exit 0
=20
@@ -22,4 +22,4 @@ if [[ $1 =3D -h ]]; then
     exit 1
 fi
=20
-exit 0
\ No newline at end of file
+exit 0
diff --git a/modules.d/90multipath/install b/modules.d/90multipath/install
index ed2d698..7c78471 100755
--- a/modules.d/90multipath/install
+++ b/modules.d/90multipath/install
@@ -1,6 +1,6 @@
 #!/bin/bash
=20
-if ldd $(which multipath) 2>/dev/null |grep -q lib64; then
+if ldd $(type -P multipath) 2>/dev/null |grep -q lib64; then
     LIBDIR=3D"/lib64"
 else
     LIBDIR=3D"/lib"
diff --git a/modules.d/95iscsi/check b/modules.d/95iscsi/check
index 5a47d97..55cb53b 100755
--- a/modules.d/95iscsi/check
+++ b/modules.d/95iscsi/check
@@ -3,7 +3,7 @@
 [ "$1" =3D "-d" ] && echo network
=20
 # If our prerequisites are not met, fail anyways.
-which iscsistart hostname iscsi-iname >/dev/null 2>&1 || exit 1
+type -P iscsistart hostname iscsi-iname >/dev/null || exit 1
=20
 # If hostonly was requested, fail the check if we are not actually
 # booting from root.
diff --git a/modules.d/95nbd/check b/modules.d/95nbd/check
index a84ed1d..aa69a41 100755
--- a/modules.d/95nbd/check
+++ b/modules.d/95nbd/check
@@ -3,7 +3,7 @@
 [ "$1" =3D "-d" ] && echo network
=20
 # If our prerequisites are not met, fail.
-which nbd-client >/dev/null 2>&1 || exit 1
+type -P nbd-client >/dev/null || exit 1
=20
 # if an nbd device is not somewhere in the chain of devices root is mounte=
d on,
 # fail the hostonly check.
diff --git a/modules.d/95nfs/check b/modules.d/95nfs/check
index f72aaae..adb53dd 100755
--- a/modules.d/95nfs/check
+++ b/modules.d/95nfs/check
@@ -7,6 +7,6 @@
 [ "$1" =3D "-h" ] && ! egrep -q '/ nfs[34 ]' /proc/mounts && exit 1
=20
 # If our prerequisites are not met, fail anyways.
-which rpcbind >/dev/null 2>&1 || which portmap >/dev/null 2>&1 || exit 1
-which rpc.statd mount.nfs mount.nfs4 umount >/dev/null 2>&1 || exit 1
+type -P rpcbind >/dev/null || type -P portmap >/dev/null || exit 1
+type -P rpc.statd mount.nfs mount.nfs4 umount >/dev/null || exit 1
 exit 0
diff --git a/modules.d/95nfs/install b/modules.d/95nfs/install
index 5d3c535..0599ff1 100755
--- a/modules.d/95nfs/install
+++ b/modules.d/95nfs/install
@@ -1,6 +1,6 @@
 #!/bin/sh
-which portmap >/dev/null 2>&1 && dracut_install portmap
-which rpcbind >/dev/null 2>&1 && dracut_install rpcbind
+type -P portmap >/dev/null && dracut_install portmap
+type -P rpcbind >/dev/null && dracut_install rpcbind
=20
 dracut_install rpc.statd mount.nfs mount.nfs4 umount=20
 [ -f /etc/netconfig ] && dracut_install /etc/netconfig=20
@@ -9,7 +9,7 @@ dracut_install /etc/nsswitch.conf /etc/rpc /etc/protocols
 dracut_install rpc.idmapd /etc/idmapd.conf
 dracut_install sed
=20
-if ldd $(which rpc.idmapd) |grep -q lib64; then
+if ldd $(type -P rpc.idmapd) |grep -q lib64; then
     LIBDIR=3D"/lib64"
 else
     LIBDIR=3D"/lib"
@@ -40,7 +40,7 @@ egrep '^nobody:' /etc/passwd >> "$initdir/etc/passwd"
 egrep '^nfsnobody:' /etc/passwd >> "$initdir/etc/passwd"
 egrep '^rpc:' /etc/passwd >> "$initdir/etc/passwd"
 egrep '^rpcuser:' /etc/passwd >> "$initdir/etc/passwd"
-#which nologin >/dev/null 2>&1 && dracut_install nologin
+#type -P nologin >/dev/null && dracut_install nologin
=20
 # rpc user needs to be able to write to this directory to save the warmsta=
rt
 # file
diff --git a/modules.d/98syslog/install b/modules.d/98syslog/install
index bf678d9..52e2fca 100755
--- a/modules.d/98syslog/install
+++ b/modules.d/98syslog/install
@@ -1,9 +1,9 @@
 #!/bin/sh
-if which rsyslogd >/dev/null; then
+if type -P rsyslogd >/dev/null; then
 	installs=3D"rsyslogd /usr/lib/rsyslog/lmnet.so /usr/lib/rsyslog/imklog.so=
 /usr/lib/rsyslog/imuxsock.so"
-elif which syslogd >/dev/null; then
+elif type -P syslogd >/dev/null; then
     installs=3D"syslogd"
-elif which syslog-ng >/dev/null; then
+elif type -P syslog-ng >/dev/null; then
     installs=3D"syslog-ng"
 else
     dwarn "Could not find any syslog binary although the syslogmodule is s=
elected to be installed. Please check."
@@ -18,4 +18,4 @@ if [ -n "$installs" ]; then
    inst_simple "$moddir/rsyslogd-stop.sh" /sbin/rsyslogd-stop
    mkdir -p ${initdir}/etc/templates
    inst_simple "${moddir}/rsyslog.conf" /etc/templates
-fi
\ No newline at end of file
+fi
diff --git a/modules.d/99base/install b/modules.d/99base/install
index 9cdb086..1d554e5 100755
--- a/modules.d/99base/install
+++ b/modules.d/99base/install
@@ -21,7 +21,7 @@ mkdir -p ${initdir}/initqueue-finished
 mkdir -p ${initdir}/initqueue-settled
 mkdir -p ${initdir}/tmp
 # Bail out if switch_root does not exist
-if which switch_root >/dev/null 2>&1; then
+if type -P switch_root >/dev/null; then
     dracut_install switch_root=20
 else
     inst "$moddir/switch_root" "/sbin/switch_root" \
diff --git a/test/TEST-20-NFS/test.sh b/test/TEST-20-NFS/test.sh
index 530a42c..24b909c 100755
--- a/test/TEST-20-NFS/test.sh
+++ b/test/TEST-20-NFS/test.sh
@@ -206,10 +206,10 @@ test_setup() {
 	    /lib/terminfo/l/linux dmesg mkdir cp ping exportfs \
 	    modprobe rpc.nfsd rpc.mountd showmount tcpdump \
 	    /etc/services sleep mount chmod
-	which portmap >/dev/null 2>&1 && dracut_install portmap
-	which rpcbind >/dev/null 2>&1 && dracut_install rpcbind
+	type -P portmap >/dev/null && dracut_install portmap
+	type -P rpcbind >/dev/null && dracut_install rpcbind
 	[ -f /etc/netconfig ] && dracut_install /etc/netconfig=20
-	which dhcpd >/dev/null 2>&1 && dracut_install dhcpd
+	type -P dhcpd >/dev/null && dracut_install dhcpd
 	[ -x /usr/sbin/dhcpd3 ] && inst /usr/sbin/dhcpd3 /usr/sbin/dhcpd
 	instmods nfsd sunrpc ipv6
 	inst ./server-init /sbin/init
@@ -218,7 +218,7 @@ test_setup() {
 	inst ./dhcpd.conf /etc/dhcpd.conf
 	dracut_install /etc/nsswitch.conf /etc/rpc /etc/protocols
 	dracut_install rpc.idmapd /etc/idmapd.conf
-	if ldd $(which rpc.idmapd) |grep -q lib64; then
+	if ldd $(type -P rpc.idmapd) |grep -q lib64; then
 	    LIBDIR=3D"/lib64"
 	else
 	    LIBDIR=3D"/lib"
diff --git a/test/TEST-30-ISCSI/test.sh b/test/TEST-30-ISCSI/test.sh
index 637f264..a0b85c3 100755
--- a/test/TEST-30-ISCSI/test.sh
+++ b/test/TEST-30-ISCSI/test.sh
@@ -161,7 +161,7 @@ test_setup() {
 	instmods iscsi_tcp crc32c ipv6
         inst ./targets /etc/iscsi/targets
 	[ -f /etc/netconfig ] && dracut_install /etc/netconfig=20
-	which dhcpd >/dev/null 2>&1 && dracut_install dhcpd
+	type -P dhcpd >/dev/null && dracut_install dhcpd
 	[ -x /usr/sbin/dhcpd3 ] && inst /usr/sbin/dhcpd3 /usr/sbin/dhcpd
 	inst ./server-init /sbin/init
 	inst ./hosts /etc/hosts
diff --git a/test/TEST-40-NBD/test.sh b/test/TEST-40-NBD/test.sh
index 1a46ed1..ba68b48 100755
--- a/test/TEST-40-NBD/test.sh
+++ b/test/TEST-40-NBD/test.sh
@@ -263,7 +263,7 @@ make_server_root() {
 	dracut_install sh ls shutdown poweroff stty cat ps ln ip \
 	    /lib/terminfo/l/linux dmesg mkdir cp ping grep \
 	    sleep nbd-server chmod
-	which dhcpd >/dev/null 2>&1 && dracut_install dhcpd
+	type -P dhcpd >/dev/null && dracut_install dhcpd
 	[ -x /usr/sbin/dhcpd3 ] && inst /usr/sbin/dhcpd3 /usr/sbin/dhcpd
 	inst ./server-init /sbin/init
 	inst ./hosts /etc/hosts
diff --git a/test/TEST-50-MULTINIC/test.sh b/test/TEST-50-MULTINIC/test.sh
index 9a3f619..e07ef3b 100755
--- a/test/TEST-50-MULTINIC/test.sh
+++ b/test/TEST-50-MULTINIC/test.sh
@@ -135,10 +135,10 @@ test_setup() {
  	    /lib/terminfo/l/linux dmesg mkdir cp ping exportfs \
  	    modprobe rpc.nfsd rpc.mountd showmount tcpdump \
  	    /etc/services sleep mount chmod
- 	which portmap >/dev/null 2>&1 && dracut_install portmap
- 	which rpcbind >/dev/null 2>&1 && dracut_install rpcbind
+ 	type -P portmap >/dev/null && dracut_install portmap
+ 	type -P rpcbind >/dev/null && dracut_install rpcbind
  	[ -f /etc/netconfig ] && dracut_install /etc/netconfig=20
- 	which dhcpd >/dev/null 2>&1 && dracut_install dhcpd
+ 	type -P dhcpd >/dev/null && dracut_install dhcpd
  	[ -x /usr/sbin/dhcpd3 ] && inst /usr/sbin/dhcpd3 /usr/sbin/dhcpd
  	instmods nfsd sunrpc ipv6
  	inst ./server-init /sbin/init
@@ -147,7 +147,7 @@ test_setup() {
  	inst ./dhcpd.conf /etc/dhcpd.conf
  	dracut_install /etc/nsswitch.conf /etc/rpc /etc/protocols
  	dracut_install rpc.idmapd /etc/idmapd.conf
- 	if ldd $(which rpc.idmapd) |grep -q lib64; then
+ 	if ldd $(type -P rpc.idmapd) |grep -q lib64; then
  	    LIBDIR=3D"/lib64"
  	else
  	    LIBDIR=3D"/lib"
--=20
1.7.2

--Sig_//XNKcFSFvfD.hebZ+nFAcR3
Content-Type: application/pgp-signature; name=signature.asc
Content-Disposition: attachment; filename=signature.asc

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.16 (GNU/Linux)

iEYEARECAAYFAkxr/GgACgkQ+hU8EsKEdQ0dmQCgsRP6nc7R1pqpB2EK/PCaVy7M
MeMAoIpdP8jxL3fEoMcaCt0c6G51wTPF
=U/WT
-----END PGP SIGNATURE-----

--Sig_//XNKcFSFvfD.hebZ+nFAcR3--
