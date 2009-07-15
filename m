From: Harald Hoyer <harald-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: [PATCH 13/14] install all /lib/kbd to initramfs, if not host only
Date: Wed, 15 Jul 2009 18:50:45 +0200
Message-ID: <1247676646-3837-14-git-send-email-harald@redhat.com>
References: <1247676646-3837-1-git-send-email-harald@redhat.com>
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1247676646-3837-1-git-send-email-harald-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: Harald Hoyer <harald-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>

KEYBOARDTYPE=sun|pc
   will be written to /etc/sysconfig/keyboard in the initramfs

KEYTABLE=<keytable file>
   will be written to /etc/sysconfig/keyboard in the initramfs

SYSFONT= Console font
   will be written to /etc/sysconfig/i18n in the initramfs

SYSFONTACM= Console map.
   will be written to /etc/sysconfig/i18n in the initramfs

UNIMAP= Unicode font map.
   will be written to /etc/sysconfig/i18n in the initramfs

LANG=<locale>
   will be written to /etc/sysconfig/i18n in the initramfs
   LANG= set locale for all categories, can be any two letter ISO
   language code
---
 dracut.8                              |   21 +++++
 modules.d/10redhat-i18n/install       |  156 ++++++++++++++++++---------------
 modules.d/10redhat-i18n/parse-i18n.sh |   14 +++
 3 files changed, 120 insertions(+), 71 deletions(-)
 rewrite modules.d/10redhat-i18n/install (67%)
 create mode 100644 modules.d/10redhat-i18n/parse-i18n.sh

diff --git a/dracut.8 b/dracut.8
index e121bf5..bcf603f 100644
--- a/dracut.8
+++ b/dracut.8
@@ -78,6 +78,27 @@ root filesystem.
 specify e.g. \fI/dev/sda1\fR or
 \fI/dev/disk/by-path/pci-0000:00:1f.1-scsi-0:0:1:0-part1\fR
 
+.SH I18N
+e.g. LANG=en_US.UTF-8 SYSFONT=latarcyrheb-sun16 KEYTABLE=de-latin1-nodeadkeys
+.TP
+.B KEYBOARDTYPE=sun|pc
+will be written to /etc/sysconfig/keyboard in the initramfs
+.TP
+.B KEYTABLE=<keytable filename>
+will be written to /etc/sysconfig/keyboard in the initramfs
+.TP
+.B SYSFONT= Console font
+will be written to /etc/sysconfig/i18n in the initramfs
+.TP
+.B SYSFONTACM= Unicode font map
+will be written to /etc/sysconfig/i18n in the initramfs
+.TP
+.B UNIMAP= Unicode font map
+will be written to /etc/sysconfig/i18n in the initramfs
+.TP
+.B LANG=<locale>
+will be written to /etc/sysconfig/i18n in the initramfs
+
 .SH LVM
 .TP
 .B rd_NO_LVM
diff --git a/modules.d/10redhat-i18n/install b/modules.d/10redhat-i18n/install
dissimilarity index 67%
index a6dbc07..cc7608b 100755
--- a/modules.d/10redhat-i18n/install
+++ b/modules.d/10redhat-i18n/install
@@ -1,71 +1,85 @@
-#!/bin/bash
-findkeymap () {
-    local MAP=$1
-    [[ ! -f $MAP ]] && \
-	MAP=$(find /lib/kbd/keymaps -type f -name $MAP -o -name $MAP.\* | head -n1)
-    [[ " $KEYMAPS " = *" $MAP "* ]] && return
-    KEYMAPS="$KEYMAPS $MAP"
-    case $MAP in
-        *.gz) cmd=zgrep;;
-        *.bz2) cmd=bzgrep;;
-        *) cmd=grep ;;
-    esac
-
-    for INCL in $($cmd "^include " $MAP | cut -d' ' -f2 | tr -d '"'); do
-        for FN in $(find /lib/kbd/keymaps -type f -name $INCL\*); do
-            findkeymap $FN
-        done
-    done
-}
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
-        inst loadkeys
-        findkeymap $KEYMAP
-
-        for FN in $KEYMAPS; do
-            if [ -L $FN ]; then
-		TARGET=$(readlink -f $FN)
-		TG=$(echo $TARGET | sed -e 's/\.gz$//' -e 's/\.bz2$//')
-		LN=$(echo $FN | sed -e 's/\.gz$//' -e 's/\.bz2$//')
-                mkdir -p "$initdir/$(dirname $LN)"
-                ln -s "$TG" "$initdir/$LN"
-                FN=$TARGET
-            fi
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
-    inst setfont
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
-
-dracut_install /lib/udev/console_*
-inst_rules 10-console.rules
-
+#!/bin/bash
+
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
+install_local()
+{
+# FIXME: i18n stuff isn't really distro-independent :/
+    if [[ -f /etc/sysconfig/keyboard || -f /etc/sysconfig/console/default.kmap ]]; then
+	if [ -f /etc/sysconfig/console/default.kmap ]; then
+            KEYMAP=/etc/sysconfig/console/default.kmap
+	else
+            . /etc/sysconfig/keyboard
+            [[ $KEYTABLE && -d /lib/kbd/keymaps ]] && KEYMAP="$KEYTABLE.map"
+	fi
+	if [[ $KEYMAP ]]; then
+            [ -f /etc/sysconfig/keyboard ] && inst /etc/sysconfig/keyboard
+            inst loadkeys
+            findkeymap $KEYMAP
+
+            for FN in $KEYMAPS; do
+		if [ -L $FN ]; then
+		    TARGET=$(readlink -f $FN)
+		    TG=$(echo $TARGET | sed -e 's/\.gz$//' -e 's/\.bz2$//')
+		    LN=$(echo $FN | sed -e 's/\.gz$//' -e 's/\.bz2$//')
+                    mkdir -p "$initdir/$(dirname $LN)"
+                    ln -s "$TG" "$initdir/$LN"
+                    FN=$TARGET
+		fi
+		inst $FN
+		case $FN in
+                    *.gz) gzip -d "$initdir$FN" ;;
+                    *.bz2) bzip2 -d "$initdir$FN" ;;
+		esac
+            done
+	fi
+    fi
+
+    if [ -f /etc/sysconfig/i18n ]; then
+	. /etc/sysconfig/i18n
+	inst /etc/sysconfig/i18n
+	[[ $SYSFONT ]] || SYSFONT=latarcyrheb-sun16
+	inst setfont
+
+	for FN in /lib/kbd/consolefonts/$SYSFONT.* ; do
+            inst "$FN"
+            case $FN in
+		*.gz) gzip -d "$initdir$FN" ;;
+		*.bz2) bzip2 -d "$initdir$FN" ;;
+            esac
+	done
+	[[ $SYSFONTACM ]] && inst /lib/kbd/consoletrans/$SYSFONTACM
+	[[ $UNIMAP ]] && inst /lib/kbd/unimaps/$UNIMAP
+    fi
+}
+
+if [[ $hostonly ]]; then 
+    install_local
+else
+    for i in $(find /lib/kbd -type f -print); do
+	dracut_install $i
+    done
+    dracut_install gzip bzip2
+fi
+
+dracut_install /lib/udev/console_* 
+dracut_install setfont loadkeys
+inst_rules 10-console.rules
+inst_hook cmdline 20 "$moddir/parse-i18n.sh"
diff --git a/modules.d/10redhat-i18n/parse-i18n.sh b/modules.d/10redhat-i18n/parse-i18n.sh
new file mode 100644
index 0000000..1bf88d6
--- /dev/null
+++ b/modules.d/10redhat-i18n/parse-i18n.sh
@@ -0,0 +1,14 @@
+inst_key_val()
+{
+    local value
+    value=$(getarg $1)
+    [ -n "$value" ] && printf '%s="%s"\n' $1 $value >> $2
+    initrdargs="$initrdargs $1" 
+}
+mkdir -p /etc/sysconfig
+inst_key_val KEYBOARDTYPE /etc/sysconfig/keyboard
+inst_key_val KEYTABLE /etc/sysconfig/keyboard
+inst_key_val SYSFONT /etc/sysconfig/i18n
+inst_key_val SYSFONTACM /etc/sysconfig/i18n
+inst_key_val UNIMAP /etc/sysconfig/i18n
+inst_key_val LANG /etc/sysconfig/i18n
-- 
1.6.2.5

--
To unsubscribe from this list: send the line "unsubscribe initramfs" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
