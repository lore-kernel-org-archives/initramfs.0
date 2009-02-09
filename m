From: Victor Lowther <victor.lowther-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: [PATCH 14/31] Some dracut cleanups and bashification.
Date: Sun, 08 Feb 2009 16:35:40 -0800 (PST)
Message-ID: <181dd2b81e83151c3a034ab6a24de0e82a9a6d0c.1234137268.git.victor.lowther@gmail.com>
References: <5a1ca330d81aeebf879bb7f0950b7ae448f7be22.1234137267.git.victor.lowther@gmail.com>
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:message-id:in-reply-to
         :references:from:subject:to:x-mailer;
        bh=7gumOuGIvMcdVliTj3Xlly/HWTXRQemMLMlaXlZmCq0=;
        b=OxrNZ9pRiTCJqQ2UcMAsjqUCZfnpAKAya4r74a8kdcr+PcQpVZb67BcLz7a7+QZhTH
         fpqQ8q22gs8fuInSTzedLto/WjJgljOxi0ZPuQjJq9PWbUjmtLHWPf4Ps61lvz1PXrO+
         g/Je3h1OnWGEA0Sblk3wsCWDKJTynGutLTpIw=
In-Reply-To: <5a1ca330d81aeebf879bb7f0950b7ae448f7be22.1234137267.git.victor.lowther-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

Tighten up conditional checking a bit more.

Use bash-style conditionals where ever it makes things shorter
and easier to read.
---
 dracut |   29 ++++++++++-------------------
 1 files changed, 10 insertions(+), 19 deletions(-)

diff --git a/dracut b/dracut
index 9de5bea..8cbe0da 100755
--- a/dracut
+++ b/dracut
@@ -66,16 +66,14 @@ done
 for f in $(find /lib/terminfo -type f) ; do cp  --parents $f "$initdir" ; done
 
 # FIXME: i18n stuff isn't really distro-independent :/
-if [ -f /etc/sysconfig/keyboard ] || [ -f /etc/sysconfig/console/default.kmap ]; then
+if [[ -f /etc/sysconfig/keyboard || -f /etc/sysconfig/console/default.kmap ]]; then
     if [ -f /etc/sysconfig/console/default.kmap ]; then
         KEYMAP=/etc/sysconfig/console/default.kmap
     else
         . /etc/sysconfig/keyboard
-        if [ -n "$KEYTABLE" -a -d "/lib/kbd/keymaps" ]; then
-            KEYMAP="$KEYTABLE.map"
-        fi
+        [[ $KEYTABLE && -d /lib/kbd/keymaps ]] && KEYMAP="$KEYTABLE.map"
     fi
-    if [ -n "$KEYMAP" ]; then
+    if [[ $KEYMAP ]]; then
         [ -f /etc/sysconfig/keyboard ] && inst /etc/sysconfig/keyboard "$initdir"
         inst /bin/loadkeys "$initdir"
         findkeymap $KEYMAP
@@ -97,7 +95,7 @@ fi
 if [ -f /etc/sysconfig/i18n ]; then
     . /etc/sysconfig/i18n
     inst /etc/sysconfig/i18n "$initdir"
-    [ -z "$SYSFONT" ] && SYSFONT=latarcyrheb-sun16
+    [[ $SYSFONT ]] || SYSFONT=latarcyrheb-sun16
     inst /bin/setfont "$initdir"
 
     for FN in /lib/kbd/consolefonts/$SYSFONT.* ; do
@@ -111,12 +109,8 @@ if [ -f /etc/sysconfig/i18n ]; then
                 ;;
         esac
     done
-    if [ -n "$SYSFONTACM" ]; then
-        inst /lib/kbd/consoletrans/$SYSFONTACM "$initdir"
-    fi
-    if [ -n "$UNIMAP" ]; then
-        inst /lib/kbd/unimaps/$UNIMAP "$initdir"
-    fi
+    [[ $SYSFONTACM ]] && inst /lib/kbd/consoletrans/$SYSFONTACM "$initdir"
+    [[ $UNIMAP ]] && inst /lib/kbd/unimaps/$UNIMAP "$initdir"
 fi
 
 # install our files
@@ -126,7 +120,7 @@ cp $switchroot "$initdir/sbin/switch_root"
 # and create some directory structure
 for d in etc proc sys sysroot dev/pts; do mkdir -p "$initdir/$d"; done
 # FIXME: hard-coded module list of doom.
-[ -z "$modules" ] && modules="=ata =block =drm dm-crypt aes sha256 cbc"
+[[ $modules ]] || modules="=ata =block =drm dm-crypt aes sha256 cbc"
 
 mkdir -p "$initdir/lib/modules/$kernel"
 # expand out module deps, etc
@@ -134,17 +128,14 @@ for mod in $(resolveAndExpandModules $modules) ; do
     installmodule $mod "$initdir"
 done
 
-/sbin/depmod -a -b "$initdir" $kernel
-if [ $? -ne 0 ]; then
+/sbin/depmod -a -b "$initdir" $kernel || {
     error "\"/sbin/depmod -a $kernel\" failed."
     exit 1
-fi
+}
 
 # plymouth
 if [ -x /usr/libexec/plymouth/plymouth-populate-initrd ]; then
     /usr/libexec/plymouth/plymouth-populate-initrd -t "$initdir" || :
 fi
 
-pushd "$initdir" >/dev/null
-find . |cpio -H newc -o |gzip -9 > "$outfile"
-popd >/dev/null
+( cd "$initdir"; find . |cpio -H newc -o |gzip -9 > "$outfile"; )
-- 
1.6.0.6

--
To unsubscribe from this list: send the line "unsubscribe initramfs" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
