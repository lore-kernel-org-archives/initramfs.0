From: Victor Lowther <victor.lowther-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: [PATCH 2/4] Get rid of some RedHat specific modules and udev rules
Date: Tue, 03 Mar 2009 16:21:13 -0800 (PST)
Message-ID: <1d16a0aef8ab7f83212bd12dd71908f5c1a1a2a5.1236124962.git.victor.lowther@gmail.com>
References: <d53985b1c536e2fb845e0e3c369edd06d5018011.1236124962.git.victor.lowther@gmail.com>
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:message-id:in-reply-to
         :references:from:subject:to:x-mailer;
        bh=6f5Rjttsvb6GFWOFEwdCUkh/H2+3ye2jMSQyPmgNIUA=;
        b=aNWkJIRbyCopvUmaZoIQaEbHiEdOyddcIWoqSx3LComjrRca0kqhT6bpdjtuZSWBZu
         KdYwfs9vySSKDWOTrkib67/ReWb4KN6hdbGNN5/Y1o868rWhkXYUMk1LjbC/SQFh/W8p
         xtB8H6qOPwXPQJV3+4KrXhVhDX5TmguqdMUX4=
In-Reply-To: <d53985b1c536e2fb845e0e3c369edd06d5018011.1236124962.git.victor.lowther-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

They are not needed to boot with dracut, so away they go.

Also rewrite inst_rules to automatically search likely rule locations when
installing udev rules.
---
 dracut-functions         |   15 +++++++++--
 modules/10redhat-i18n.sh |   59 ----------------------------------------------
 modules/95udev-rules.sh  |    9 +++----
 3 files changed, 16 insertions(+), 67 deletions(-)

diff --git a/dracut-functions b/dracut-functions
index f40694e..fbcf315 100755
--- a/dracut-functions
+++ b/dracut-functions
@@ -55,7 +55,7 @@ inst_library() {
 	
 find_binary() {
     local binpath="/bin /sbin /usr/bin /usr/sbin" p
-    [[ ${1##*/} = $1 ]] || { echo $1; return 0; }
+    [[ ${1##*/} != $1 && -x $1 ]] && { echo $1; return 0; }
     for p in $binpath; do
 	[[ -x $p/$1 ]] && { echo "$p/$1"; return 0; }
     done
@@ -119,11 +119,19 @@ inst_symlink() {
     inst "$realsrc" && ln -s "$realsrc" "$target"
 }
 
+find_rule() {
+    for r in . /lib/udev/rules.d /etc/udev/rules.d $dsrc/rules.d; do
+	[[ -f $r/$1 ]] && { echo "$r/$1"; return 0; }
+    done
+    return 1
+}
+
 # udev rules always get installed in the same place, so
 # create a function to install them to make life simpler.
 inst_rules() { 
     for rule in "$@"; do 
-	inst_simple "$rule" "/lib/udev/rules.d/${rule##*/}"
+	rule=$(find_rule $rule) && \
+	    inst_simple "$rule" "/lib/udev/rules.d/${rule##*/}"
     done
 }
 
@@ -134,7 +142,8 @@ inst() {
         echo "usage: inst <file> <root> [<destination file>]"
         return 1
     fi
-    local src=$(find_binary "$1") || {
+    local src dest
+    src=$(find_binary "$1") || {
 	echo "Cannot find requested file $1. Exiting."
 	exit 1
     }
diff --git a/modules/10redhat-i18n.sh b/modules/10redhat-i18n.sh
deleted file mode 100755
index ae50bbc..0000000
--- a/modules/10redhat-i18n.sh
+++ /dev/null
@@ -1,59 +0,0 @@
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
diff --git a/modules/95udev-rules.sh b/modules/95udev-rules.sh
index 61125cd..c11752f 100755
--- a/modules/95udev-rules.sh
+++ b/modules/95udev-rules.sh
@@ -3,10 +3,9 @@
 # ultimately, /lib/initramfs/rules.d or somesuch which includes links/copies
 # of the rules we want so that we just copy those in would be best
 mkdir -p "$initdir/lib/udev/rules.d"
-dracut_install udevd udevadm /lib/udev/*_id /lib/udev/console_*
-inst_rules /lib/udev/rules.d/10-console* /lib/udev/rules.d/40-redhat* \
-    /lib/udev/rules.d/50* /lib/udev/rules.d/60-persistent-storage.rules \
-    /lib/udev/rules.d/61*edd* /lib/udev/rules.d/64* /lib/udev/rules.d/80* \
-    /lib/udev/rules.d/95*
+dracut_install udevd udevadm /lib/udev/*_id
+inst_rules 50-udev-default.rules 60-persistent-storage.rules \
+    61-persistent-storage-edd.rules 64-device-mapper.rules \
+    64-md-raid.rules 80-drivers.rules 95-udev-late.rules
 # make udevadm shut up about missing udev.conf
 inst /etc/udev/udev.conf
\ No newline at end of file
-- 
1.6.0.6

--
To unsubscribe from this list: send the line "unsubscribe initramfs" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
