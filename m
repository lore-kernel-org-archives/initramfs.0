From: Victor Lowther <victor.lowther-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: [PATCH 11/31] Some dracut cleanups and bashification.
Date: Sun, 08 Feb 2009 16:35:25 -0800 (PST)
Message-ID: <7949b036158d15ead05ca4a52ceba19e823e2ed4.1234137268.git.victor.lowther@gmail.com>
References: <5a1ca330d81aeebf879bb7f0950b7ae448f7be22.1234137267.git.victor.lowther@gmail.com>
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:message-id:in-reply-to
         :references:from:subject:to:x-mailer;
        bh=uuiv5gbtRzL87PHXjwcfTe7PPChaTwsWqme5+jrVHyw=;
        b=gusnGkGqqJLJa/4e9HYiNRnjhgqiV2GlRgtZ2xDFk4Apsrgmxe8dtZawrUGnw2x0ec
         gqDjrpyEvAjhX1N/gPMjHQp9x55TTBCrzFxqQXzOkslQdnkcupD5bYPHQ2qX8uFaKGsI
         Pxk10Y4Our1aRNGFMeOrxR2akFDJr4q1F6bRs=
In-Reply-To: <5a1ca330d81aeebf879bb7f0950b7ae448f7be22.1234137267.git.victor.lowther-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

Quote variable expansion where needed.

Otherwise, spaces in some filenames may make things interesting some fine day.
---
 dracut |   25 ++++++++++++-------------
 1 files changed, 12 insertions(+), 13 deletions(-)

diff --git a/dracut b/dracut
index bd592d0..7ba4a09 100755
--- a/dracut
+++ b/dracut
@@ -57,7 +57,7 @@ udevexe="/lib/udev/vol_id /lib/udev/console_init"
 
 # install base files
 for binary in $exe $debugexe $udevexe $lvmexe $cryptexe ; do
-  inst $binary $initdir
+  inst $binary "$initdir"
 done
 
 # FIXME: would be nice if we didn't have to know which rules to grab....
@@ -65,7 +65,7 @@ done
 # of the rules we want so that we just copy those in would be best
 mkdir -p $initdir/lib/udev/rules.d
 for rule in /lib/udev/rules.d/10-console* /lib/udev/rules.d/40-redhat* /lib/udev/rules.d/50* /lib/udev/rules.d/60-persistent-storage.rules /lib/udev/rules.d/61*edd* /lib/udev/rules.d/64* /lib/udev/rules.d/80* /lib/udev/rules.d/95* $rulesdir/*.rules ; do
-  cp $rule $initdir/lib/udev/rules.d
+  cp "$rule" "$initdir/lib/udev/rules.d"
 done
 
 # terminfo bits make things work better if you fall into interactive mode
@@ -107,8 +107,8 @@ if [ -f /etc/sysconfig/i18n ]; then
     inst /bin/setfont "$initdir"
 
     for FN in /lib/kbd/consolefonts/$SYSFONT.* ; do
-        inst $FN "$initdir"
-        case "$FN" in
+        inst "$FN" "$initdir"
+        case $FN in
             *.gz)
                 gzip -d "$MNTIMAGE$FN"
                 ;;
@@ -126,22 +126,21 @@ if [ -f /etc/sysconfig/i18n ]; then
 fi
 
 # install our files
-cp $initfile $initdir/init
-cp $switchroot $initdir/sbin/switch_root
+cp $initfile "$initdir/init"
+cp $switchroot "$initdir/sbin/switch_root"
 
 # and create some directory structure
-mkdir -p $initdir/etc $initdir/proc $initdir/sys $initdir/sysroot $initdir/dev/pts
-
+for d in etc proc sys sysroot dev/pts; do mkdir -p "$initdir/$d"; done
 # FIXME: hard-coded module list of doom.
 [ -z "$modules" ] && modules="=ata =block =drm dm-crypt aes sha256 cbc"
 
-mkdir -p $initdir/lib/modules/$kernel
+mkdir -p "$initdir/lib/modules/$kernel"
 # expand out module deps, etc
 for mod in $(resolveAndExpandModules $modules) ; do
-    installmodule $mod $initdir
+    installmodule $mod "$initdir"
 done
 
-/sbin/depmod -a -b $initdir $kernel
+/sbin/depmod -a -b "$initdir" $kernel
 if [ $? -ne 0 ]; then
     error "\"/sbin/depmod -a $kernel\" failed."
     exit 1
@@ -152,6 +151,6 @@ if [ -x /usr/libexec/plymouth/plymouth-populate-initrd ]; then
     /usr/libexec/plymouth/plymouth-populate-initrd -t "$initdir" || :
 fi
 
-pushd $initdir >/dev/null
-find . |cpio -H newc -o |gzip -9 > $outfile
+pushd "$initdir" >/dev/null
+find . |cpio -H newc -o |gzip -9 > "$outfile"
 popd >/dev/null
-- 
1.6.0.6

--
To unsubscribe from this list: send the line "unsubscribe initramfs" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
