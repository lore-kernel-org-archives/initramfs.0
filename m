From: initramfs mailing list <initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Subject: [PATCH 14/50] Tighten up conditional checking a bit more.
Date: Mon, 16 Feb 2009 14:06:13 -0500
Message-ID: <200902161906.n1GJ6DNL027857@hera.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

Gitweb:     http://git.kernel.org/?p=linux/kernel/git/davej/dracut.git;a=commit;h=3c3e1e0c4941d15cf21353421b0c616ea075d9dc
Commit:     3c3e1e0c4941d15cf21353421b0c616ea075d9dc
Parent:     535df366535e64c716a635548346e20aa17d753a
Author:     Victor Lowther <victor.lowther-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
AuthorDate: Fri Feb 13 04:42:04 2009 -0800
Committer:  Dave Jones <davej-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
CommitDate: Mon Feb 16 13:56:41 2009 -0500

    [PATCH 14/50] Tighten up conditional checking a bit more.
    
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
To unsubscribe from this list: send the line "unsubscribe initramfs" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
