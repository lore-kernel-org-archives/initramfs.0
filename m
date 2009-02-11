From: Victor Lowther <victor.lowther-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: [PATCH 9/9] Dracut cleanups, part 2
Date: Wed, 11 Feb 2009 03:46:56 -0800 (PST)
Message-ID: <eedbacb245954b94723e490c405d559aa69e51c5.1234351770.git.victor.lowther@gmail.com>
References: <215b373ce2de8b9c47c7f3bd3550c7fc96a49614.1234351770.git.victor.lowther@gmail.com>
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:message-id:in-reply-to
         :references:from:subject:to:x-mailer;
        bh=eQnVBcKd1jvMRYwtCidzlcGTVH89KomTsJa5ndjHK2I=;
        b=nmoiOSBrJe+IpbrV9aHxSpHlo4CUZIT2rWylCOVlijUjVj1jJ48stE0Gi4N0vCpgW4
         b4wdR6wVZr3Ae4Q3SyR6Y12la+W4phPnLscj+87mRP9xH4VDOfScJVzmPXmaatpgtqC5
         QJXI/5UezcDtRKS1f6dLMqfa+ZPlqx/7DJSxQ=
In-Reply-To: <215b373ce2de8b9c47c7f3bd3550c7fc96a49614.1234351770.git.victor.lowther-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

Rearranged dracut script to make it easier to split things out for 
modularization.

---
 dracut |   55 +++++++++++++++++++++++++++++++++----------------------
 1 files changed, 33 insertions(+), 22 deletions(-)

diff --git a/dracut b/dracut
index 186d6ad..30f0f9d 100755
--- a/dracut
+++ b/dracut
@@ -42,6 +42,11 @@ hookdirs="pre-udev pre-mount pre-pivot"
 initdir=$(mktemp -d -t initramfs.XXXXXX)
 trap 'rm -rf "$initdir"' 0 # clean up after ourselves no matter how we die.
 
+# Create some directory structure first
+for d in bin sbin usr/bin usr/sbin usr/lib etc proc sys sysroot dev/pts; do 
+    mkdir -p "$initdir/$d"; 
+done
+
 # executables that we have to have
 exe="/bin/bash /bin/mount /bin/mknod /bin/mkdir /sbin/modprobe /sbin/udevd /sbin/udevadm /sbin/nash /sbin/pidof /bin/sleep /usr/sbin/chroot /bin/echo /bin/cat /bin/sed"
 lvmexe="/sbin/lvm"
@@ -51,7 +56,7 @@ debugexe="/bin/ls /bin/ln /bin/ps /bin/grep /bin/more /bin/dmesg"
 # udev things we care about
 udevexe="/lib/udev/vol_id /lib/udev/console_init"
 
-# install base files
+# install base executables
 for binary in $exe $debugexe $udevexe $lvmexe $cryptexe ; do
   inst $binary
 done
@@ -62,6 +67,26 @@ if [[ -f /bin/dash ]]; then
     ln -sf /bin/dash "${initdir}/bin/sh"
 fi
 
+# install our scripts and hooks
+inst "$initfile" "/init"
+inst "$switchroot" "/sbin/switch_root"
+inst "$echoer" "/echoer"
+for hookdir in $hookdirs; do
+    for hook in "$dsrc/$hookdir"/*; do
+	[[ -f $hook ]] && inst "$hook" "/$hookdir/${hook##*/}"
+    done
+done
+
+# FIXME: hard-coded module list of doom.
+[[ $modules ]] || modules="=ata =block =drm dm-crypt aes sha256 cbc"
+
+instmods $modules
+
+# Grab modules for all filesystem types we currently have mounted
+while read d mp t rest; do
+    instmods "$t"
+done </proc/mounts
+
 # FIXME: would be nice if we didn't have to know which rules to grab....
 # ultimately, /lib/initramfs/rules.d or somesuch which includes links/copies
 # of the rules we want so that we just copy those in would be best
@@ -73,6 +98,8 @@ done
 # terminfo bits make things work better if you fall into interactive mode
 for f in $(find /lib/terminfo -type f) ; do cp  --parents $f "$initdir" ; done
 
+## this stuff should be moved out of the main dracut script
+
 # FIXME: i18n stuff isn't really distro-independent :/
 if [[ -f /etc/sysconfig/keyboard || -f /etc/sysconfig/console/default.kmap ]]; then
     if [ -f /etc/sysconfig/console/default.kmap ]; then
@@ -113,31 +140,15 @@ if [ -f /etc/sysconfig/i18n ]; then
     [[ $UNIMAP ]] && inst /lib/kbd/unimaps/$UNIMAP
 fi
 
-# install our files
-inst "$initfile" "/init"
-inst "$switchroot" "/sbin/switch_root"
-inst "$echoer" "/echoer"
-for hookdir in $hookdirs; do
-    for hook in "$dsrc/$hookdir"/*; do
-	[[ -f $hook ]] && inst "$hook" "/$hookdir/${hook##*/}"
-    done
-done
-
-# and create some directory structure
-for d in etc proc sys sysroot dev/pts; do mkdir -p "$initdir/$d"; done
-# FIXME: hard-coded module list of doom.
-[[ $modules ]] || modules="=ata =block =drm dm-crypt aes sha256 cbc"
-
-instmods $modules
-
-# Grab modules for all filesystem types we currently know about
-while read d mp t rest; do
-    instmods "$t"
-done </proc/mounts
+## final stuff that has to happen
 
+# generate module dependencies for the initrd
 /sbin/depmod -a -b "$initdir" $kernel || {
     error "\"/sbin/depmod -a $kernel\" failed."
     exit 1
 }
 
+# make sure that library links are correct and up to date
+ldconfig -r "$initdir"
+
 ( cd "$initdir"; find . |cpio -H newc -o |gzip -9 > "$outfile"; )
-- 
1.6.0.6

--
To unsubscribe from this list: send the line "unsubscribe initramfs" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
