From: Colin Guthrie <colin-odJJhXpcy38dnm+yROfE0A@public.gmane.org>
Subject: [PATCH] Extend 52f1b041 to allow devices to be specified in config files as well as cmdline.
Date: Mon, 21 Jan 2013 11:23:19 +0000
Message-ID: <1358767399-17302-1-git-send-email-colin@mageia.org>
Mime-Version: 1.0
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="utf-8"
To: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: Colin Guthrie <colin-odJJhXpcy38dnm+yROfE0A@public.gmane.org>

This also changes the command line switch to be --add-device and the
config directive is set to add_device. This was chosen as device=3D in =
the
config file seems too generic and not quite as consistent with other
directives (i.e. drivers/add_drivers)

The --device command line is still supported but it should be considere=
d
deprecated in favour of --add-device.
---
 dracut.8.asc      |  7 +++++--
 dracut.conf.5.asc |  5 +++++
 dracut.sh         | 15 +++++++++++++--
 3 files changed, 23 insertions(+), 4 deletions(-)

diff --git a/dracut.8.asc b/dracut.8.asc
index 6300055..da7f327 100644
--- a/dracut.8.asc
+++ b/dracut.8.asc
@@ -332,8 +332,11 @@ provide a valid _/etc/fstab_.
     Mount _<device>_ on _<mountpoint>_ with _<filesystem type>_ and _<=
filesystem
     options>_ in the initramfs
=20
-**--device** _<device>_ ::
-    Bring up _<device>_ in initramfs, _<device>_ should be the device =
name
+**--add-device** _<device>_ ::
+    Bring up _<device>_ in initramfs, _<device>_ should be the device =
name.
+    This can be useful in hostonly mode for resume support when your s=
wap is on
+    LVM or an encrypted partition.
+    [NB --device can be used for compatibility with earlier releases]
=20
 **-i, --include**=C2=A0_<SOURCE>_=C2=A0_<TARGET>_::
     include the files in the SOURCE directory into the
diff --git a/dracut.conf.5.asc b/dracut.conf.5.asc
index 68bd9eb..e545451 100644
--- a/dracut.conf.5.asc
+++ b/dracut.conf.5.asc
@@ -82,6 +82,11 @@ If chrooted to another root other than the real root=
 device, use --fstab and pro
 *add_fstab+=3D*"=C2=A0__<filename>__=C2=A0"::
     Add entries of __<filename>__ to the initramfs /etc/fstab.
=20
+*add_device+=3D*"=C2=A0__<device>__=C2=A0"::
+    Bring up _<device>_ in initramfs, _<device>_ should be the device =
name.
+    This can be useful in hostonly mode for resume support when your s=
wap is on
+    LVM an encrypted partition.
+
 *mdadmconf=3D*"__{yes|no}__"::
     Include local _/etc/mdadm.conf_ (default=3Dyes)
=20
diff --git a/dracut.sh b/dracut.sh
index 469f408..23ffaa4 100755
--- a/dracut.sh
+++ b/dracut.sh
@@ -134,7 +134,7 @@ Creates initial ramdisk images for preloading modul=
es
   --mount "[DEV] [MP] [FSTYPE] [FSOPTS]"
                         Mount device [DEV] on mountpoint [MP] with fil=
esystem
                         [FSTYPE] and options [FSOPTS] in the initramfs
-  --device "[DEV]"      Bring up [DEV] in initramfs
+  --add-device "[DEV]"  Bring up [DEV] in initramfs
   -i, --include [SOURCE] [TARGET]
                         Include the files in the SOURCE directory into=
 the
                          Target directory in the final initramfs.
@@ -331,7 +331,8 @@ while :; do
         --fscks)       push fscks_l              "$2"; shift;;
         --add-fstab)   push add_fstab_l          "$2"; shift;;
         --mount)       push fstab_lines          "$2"; shift;;
-        --device)      push host_devs            "$2"; shift;;
+        --add-device|--device)
+                       push add_device_l         "$2"; shift;;
         --kernel-cmdline) push kernel_cmdline_l  "$2"; shift;;
         --nofscks)     nofscks_l=3D"yes";;
         --ro-mnt)      ro_mnt_l=3D"yes";;
@@ -734,6 +735,16 @@ for f in $add_fstab; do
     done < $f
 done
=20
+if (( ${#add_device_l[@]} )); then
+    while pop add_device_l val; do
+        add_device+=3D" $val "
+    done
+fi
+
+for dev in $add_device; do
+    push host_devs $dev
+done
+
 if [[ $hostonly ]]; then
     # in hostonly mode, determine all devices, which have to be access=
ed
     # and examine them for filesystem types
--=20
1.8.1
