From: dyoung-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org
Subject: [patch v2 3/3] Add a dracut option --device to bring up a device in initramfs
Date: Thu, 23 Aug 2012 11:02:24 +0800
Message-ID: <20120823030628.297605642@redhat.com>
References: <20120823030221.587864989@redhat.com>
Mime-Version: 1.0
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline; filename=0816-3-add-raw-device.patch
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: TEXT/PLAIN; charset="utf-8"
To: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, harald-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org, chaowang-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org, vgoyal-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org
Cc: Dave Young <dyoung-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>

Kdump support dump to raw device which could be on top of complex stora=
ge
such as multipath and iscsi which are standalone dracut modules.

Add a --device option to dracut which will add the device to host_devs =
so
dracut can add the dependent modules automaticlly and enable them in in=
itramfs.

--device will accept device node name as the param.

Signed-off-by: Dave Young <dyoung-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Tested-by: Chao Wang <chaowang-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
---
 dracut.8.asc |    3 +++
 dracut.sh    |    3 +++
 2 files changed, 6 insertions(+)

--- dracut.orig/dracut.sh
+++ dracut/dracut.sh
@@ -133,6 +133,7 @@ Creates initial ramdisk images for prelo
   --mount "[DEV] [MP] [FSTYPE] [FSOPTS]"
                         Mount device [DEV] on mountpoint [MP] with fil=
esystem
                         [FSTYPE] and options [FSOPTS] in the initramfs
+  --device "[DEV]"      Bring up [DEV] in initramfs
   -i, --include [SOURCE] [TARGET]
                         Include the files in the SOURCE directory into=
 the
                          Target directory in the final initramfs.
@@ -261,6 +262,7 @@ TEMP=3D$(unset POSIXLY_CORRECT; getopt \
     --long fscks: \
     --long add-fstab: \
     --long mount: \
+    --long device: \
     --long nofscks: \
     --long ro-mnt \
     --long kmoddir: \
@@ -327,6 +329,7 @@ while :; do
         --fscks)       push fscks_l              "$2"; shift;;
         --add-fstab)   push add_fstab_l          "$2"; shift;;
         --mount)       push fstab_lines          "$2"; shift;;
+        --device)      push host_devs            "$2"; shift;;
         --nofscks)     nofscks_l=3D"yes";;
         --ro-mnt)      ro_mnt_l=3D"yes";;
         -k|--kmoddir)  drivers_dir_l=3D"$2"; shift;;
--- dracut.orig/dracut.8.asc
+++ dracut/dracut.8.asc
@@ -321,6 +321,9 @@ provide a valid _/etc/fstab_.
     Mount _<device>_ on _<mountpoint>_ with _<filesystem type>_ and _<=
filesystem
     options>_ in the initramfs
=20
+**--device** _<device>_ ::
+    Bring up _<device>_ in initramfs, _<device>_ should be the device =
name
+
 **-i, --include**=C2=A0_<SOURCE>_=C2=A0_<TARGET>_::
     include the files in the SOURCE directory into the
     TARGET directory in the final initramfs. If SOURCE is a file, it w=
ill be
