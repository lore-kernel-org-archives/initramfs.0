From: Victor Lowther <victor.lowther-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: [PATCH 2/5] Even more dracut cleanups
Date: Wed, 11 Feb 2009 15:42:01 -0800 (PST)
Message-ID: <fbab628ca7583549ed899a3b2a881f31b6e4715b.1234395178.git.victor.lowther@gmail.com>
References: <255e595fd4f868ab0f6e085deb0bfd4a2afc8ae7.1234395178.git.victor.lowther@gmail.com>
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:message-id:in-reply-to
         :references:from:subject:to:x-mailer;
        bh=oj3XUphFhNIY7h/e3D9q4fmeod/X+ANohSclCdYHUFg=;
        b=RnE7fbmcHfF0DEc07ImY86DkyY0VRSAqnDe2Ow4VfZ7z1+JpqK/UkaYhJKU1a5Dukf
         9N1VTmcLkR8QDvT3ScwOTeaJ3v7rVC+86Sw75Y4kWN7nAGQ8Ej3QADvVwLRfeiSb648c
         mgwEoen/DCflHVwhVu/ndyS03iTr7orFY8UcM=
In-Reply-To: <255e595fd4f868ab0f6e085deb0bfd4a2afc8ae7.1234395178.git.victor.lowther-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

Add very basic module functionality to dracut.

Move the i18n stuff to it.
---
 dracut                |   45 +++----------------------------------
 dracut-functions      |    2 -
 modules/10redhat-i18n |   59 +++++++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 63 insertions(+), 43 deletions(-)

diff --git a/dracut b/dracut
index 1042a0a..3e3d6f7 100755
--- a/dracut
+++ b/dracut
@@ -98,47 +98,10 @@ done
 # terminfo bits make things work better if you fall into interactive mode
 for f in $(find /lib/terminfo -type f) ; do cp  --parents $f "$initdir" ; done
 
-## this stuff should be moved out of the main dracut script
-
-# FIXME: i18n stuff isn't really distro-independent :/
-if [[ -f /etc/sysconfig/keyboard || -f /etc/sysconfig/console/default.kmap ]]; then
-    if [ -f /etc/sysconfig/console/default.kmap ]; then
-        KEYMAP=/etc/sysconfig/console/default.kmap
-    else
-        . /etc/sysconfig/keyboard
-        [[ $KEYTABLE && -d /lib/kbd/keymaps ]] && KEYMAP="$KEYTABLE.map"
-    fi
-    if [[ $KEYMAP ]]; then
-        [ -f /etc/sysconfig/keyboard ] && inst /etc/sysconfig/keyboard
-        inst /bin/loadkeys
-        findkeymap $KEYMAP
-
-        for FN in $KEYMAPS; do
-            inst $FN
-            case $FN in
-                *.gz) gzip -d "$initdir$FN" ;;
-                *.bz2) bzip2 -d "$initdir$FN" ;;
-            esac
-        done
-    fi
-fi
-
-if [ -f /etc/sysconfig/i18n ]; then
-    . /etc/sysconfig/i18n
-    inst /etc/sysconfig/i18n
-    [[ $SYSFONT ]] || SYSFONT=latarcyrheb-sun16
-    inst /bin/setfont
-
-    for FN in /lib/kbd/consolefonts/$SYSFONT.* ; do
-        inst "$FN"
-        case $FN in
-            *.gz) gzip -d "$initdir$FN" ;;
-            *.bz2) bzip2 -d "$initdir$FN" ;;
-        esac
-    done
-    [[ $SYSFONTACM ]] && inst /lib/kbd/consoletrans/$SYSFONTACM
-    [[ $UNIMAP ]] && inst /lib/kbd/unimaps/$UNIMAP
-fi
+# source any third-party package provided modules
+for f in "$dsrc/modules"/*; do
+    [[ -x $f ]] && . "$f"
+done
 
 ## final stuff that has to happen
 
diff --git a/dracut-functions b/dracut-functions
index 52ef722..8beba8b 100755
--- a/dracut-functions
+++ b/dracut-functions
@@ -120,10 +120,8 @@ inst_symlink() {
     inst "$realsrc" && ln -s "$realsrc" "$target"
 }
 
-
 # general purpose installation function
 # Same args as above.
-# Just tries to install as a binary, a shell script, then a simple data file.
 inst() {
     if (($# != 1 && $# != 2)); then
         echo "usage: inst <file> <root> [<destination file>]"
diff --git a/modules/10redhat-i18n b/modules/10redhat-i18n
new file mode 100644
index 0000000..ae50bbc
--- /dev/null
+++ b/modules/10redhat-i18n
@@ -0,0 +1,59 @@
+#!/bin/bash
+findkeymap () {
+    local MAP=$1
+    [[ ! -f $MAP ]] && \
+	MAP=$(find /lib/kbd/keymaps -type f -name $MAP -o -name $MAP.\* | head -n1)
+    [[ " $KEYMAPS " = *" $MAP "* ]] && return
+    KEYMAPS="$KEYMAPS $MAP"
+    case $MAP in
+        *.gz) cmd=zgrep;;
+        *.bz2) cmd=bzgrep;;
+        *) cmd=grep ;;
+    esac
+
+    for INCL in $($cmd "^include " $MAP | cut -d' ' -f2 | tr -d '"'); do
+        for FN in $(find /lib/kbd/keymaps -type f -name $INCL\*); do
+            findkeymap $FN
+        done
+    done
+}
+
+# FIXME: i18n stuff isn't really distro-independent :/
+if [[ -f /etc/sysconfig/keyboard || -f /etc/sysconfig/console/default.kmap ]]; then
+    if [ -f /etc/sysconfig/console/default.kmap ]; then
+        KEYMAP=/etc/sysconfig/console/default.kmap
+    else
+        . /etc/sysconfig/keyboard
+        [[ $KEYTABLE && -d /lib/kbd/keymaps ]] && KEYMAP="$KEYTABLE.map"
+    fi
+    if [[ $KEYMAP ]]; then
+        [ -f /etc/sysconfig/keyboard ] && inst /etc/sysconfig/keyboard
+        inst loadkeys
+        findkeymap $KEYMAP
+
+        for FN in $KEYMAPS; do
+            inst $FN
+            case $FN in
+                *.gz) gzip -d "$initdir$FN" ;;
+                *.bz2) bzip2 -d "$initdir$FN" ;;
+            esac
+        done
+    fi
+fi
+
+if [ -f /etc/sysconfig/i18n ]; then
+    . /etc/sysconfig/i18n
+    inst /etc/sysconfig/i18n
+    [[ $SYSFONT ]] || SYSFONT=latarcyrheb-sun16
+    inst setfont
+
+    for FN in /lib/kbd/consolefonts/$SYSFONT.* ; do
+        inst "$FN"
+        case $FN in
+            *.gz) gzip -d "$initdir$FN" ;;
+            *.bz2) bzip2 -d "$initdir$FN" ;;
+        esac
+    done
+    [[ $SYSFONTACM ]] && inst /lib/kbd/consoletrans/$SYSFONTACM
+    [[ $UNIMAP ]] && inst /lib/kbd/unimaps/$UNIMAP
+fi
-- 
1.6.0.6

--
To unsubscribe from this list: send the line "unsubscribe initramfs" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
