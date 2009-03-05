From: Victor Lowther <victor.lowther-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: [PATCH 2/3] Grab only the udev rules we need to survive
Date: Wed, 04 Mar 2009 18:51:39 -0800 (PST)
Message-ID: <bd5c5f6281437d8fdfb9f8776c4bf3e72f8eddf6.1236220864.git.victor.lowther@gmail.com>
References: <c79c304ad7c2ef19b138c43f89f9b7244b57a6f4.1236220864.git.victor.lowther@gmail.com>
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:message-id:in-reply-to
         :references:from:subject:to:x-mailer;
        bh=+0j1MsKhUp6deZOxIEoCGfAqrLjmq2Pbi5XJT7cBkts=;
        b=baRDw2+4eFDwhVkS9Q/aTZoCkl5i0CGwGvzKz3WpA3AtaXbGk7Po47/SOHshWyUieT
         41bHrcVOPGHcHjuow27lbjqCobur0rHxSP8aO05lNn5kWoUqNsWU5Ym6OqcPmEZv2uEY
         71oinM1/3hKRdYWCnJj6HQ7XzqJfUzqn76Z1g=
In-Reply-To: <c79c304ad7c2ef19b138c43f89f9b7244b57a6f4.1236220864.git.victor.lowther-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

Also rewrite inst_rules to automatically search likely locations, and get rid
of the redhat-specific i18n code.  I know that this can potentially have
catastrophic experiences on people running with encrypted root partitions, but
I do not have enough knowledge to steal the i18n bits from the other major
distros in a distro-agnostic fashion.  This can and should be added back, but
not as a part of the master branch.  Perhaps a redhat branch containing only
redhat-specific modules could be created as a branch that shaares no ancestry
with the main dracut branches -- that would also be a good place to stash the
dracut.spec

---
 dracut-functions         |   15 +++++++++--
 modules/10redhat-i18n.sh |   59 ----------------------------------------------
 modules/95udev-rules.sh  |    9 +++----
 3 files changed, 16 insertions(+), 67 deletions(-)

diff --git a/dracut-functions b/dracut-functions
index 4a98019..bb6e972 100755
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
