From: Dave Young <dyoung-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: [PATCH] add default values in fstab_lines
Date: Fri, 14 Feb 2014 16:49:21 +0800
Message-ID: <20140214084921.GA30064@dhcp-16-126.nay.redhat.com>
Mime-Version: 1.0
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="iso-8859-1"
To: harald-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org, vgoyal-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org, initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

It's useful for passing a full fstab line including like fs_passno so f=
sck
can take effect.

Previously it's assumed that there's no fs_freq and fs_passno in fstab =
lines
so original code just append "0 0" at the end of each fstab lines.

Improve this issue by assign default value in case they are not passed =
in.
Three field are handled here:
fs_mntops: default to "defaults"
fs_freq: default to "0"
fs_passno: default to "0"=20

Signed-off-by: Dave Young <dyoung-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
---
 dracut.8.asc |    8 ++++++--
 dracut.sh    |    6 +++++-
 2 files changed, 11 insertions(+), 3 deletions(-)

--- dracut.orig/dracut.sh
+++ dracut/dracut.sh
@@ -1222,7 +1222,11 @@ if [[ $kernel_only !=3D yes ]]; then
     [[ $kernel_cmdline ]] && printf "%s\n" "$kernel_cmdline" >> "${ini=
tdir}/etc/cmdline.d/01-default.conf"
=20
     while pop fstab_lines line; do
-        printf "%s\n" "$line 0 0" >> "${initdir}/etc/fstab"
+        line=3D($line)
+        [ -z "${line[3]}" ] && line[3]=3D"defaults"
+        [ -z "${line[4]}" ] && line[4]=3D"0"
+        [ -z "${line[5]}" ] && line[5]=3D"0"
+        echo "${line[@]}" >> "${initdir}/etc/fstab"
     done
=20
     for f in $add_fstab; do
--- dracut.orig/dracut.8.asc
+++ dracut/dracut.8.asc
@@ -311,9 +311,13 @@ provide a valid _/etc/fstab_.
 **--add-fstab** _<filename>_::
     Add entries of _<filename>_ to the initramfs /etc/fstab.
=20
-**--mount**=A0"_<device>_ _<mountpoint>_ _<filesystem type>_ _<filesys=
tem options>_"::
+**--mount**=A0"_<device>_ _<mountpoint>_ _<filesystem type>_ _<filesys=
tem options>_ _<dump options>_ _<fsck order>_"::
     Mount _<device>_ on _<mountpoint>_ with _<filesystem type>_ and _<=
filesystem
-    options>_ in the initramfs
+    options>_ in the initramfs. _<dump options>_ and _<fsck order>_ ca=
n also be
+    specified, see fstab manpage for the details.
+    The default _<filesystem options>_ is "defaults".
+    The default _<dump options>_ is "0".
+    the default _<fsck order>_ is "2".
=20
 **--add-device** _<device>_ ::
     Bring up _<device>_ in initramfs, _<device>_ should be the device =
name.
