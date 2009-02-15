From: Victor Lowther <victor.lowther-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: [PATCH 2/1] switch_root: now uglier and more robust.
Date: Sat, 14 Feb 2009 20:06:42 -0600
Message-ID: <1234663602.5199.2.camel@sentry-no.fnordovax.org>
References: <87fce43b083281714e24852cd20a86836667bdcf.1234619174.git.victor.lowther@gmail.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:subject:from:to:in-reply-to
         :references:content-type:date:message-id:mime-version:x-mailer
         :content-transfer-encoding;
        bh=q3L680JVuEINKhJyGtl6ZeL6EOlhdSOPE1RyMP6UNJA=;
        b=cFira9MBinTQR0XWdgNaMJNej2ioKV0X6afINQzWSEl/u5j/9sWqB0h/WAvwF/IxhL
         /GcU3WdKT5EplLXHg2oaz+e0jmT8/v1iv7tAIFKtHLXhtCoyVs1vVNVBTEItUN+ZiuLI
         RwzXFv2gkMNr2Pq68QhjAPW8Y8xO5gGTGw4kE=
In-Reply-To: <87fce43b083281714e24852cd20a86836667bdcf.1234619174.git.victor.lowther-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

switch_root no is no longer generated on the fly whenever a ramdisk is created.
It is smart enough to figure out most everything needed to change to the
real root.

---
 modules/90gen-switch_root |   28 -----------------
 switch_root               |   75 +++++++++++++++++++++++++++++++++++++++++++++
 switch_root.in            |   30 ------------------
 3 files changed, 75 insertions(+), 58 deletions(-)

diff --git a/modules/90gen-switch_root b/modules/90gen-switch_root
deleted file mode 100755
index 0699aed..0000000
--- a/modules/90gen-switch_root
+++ /dev/null
@@ -1,28 +0,0 @@
-#!/bin/bash
-(
-    RM=$(find_binary rm)
-    INIT=$(find_binary init)
-    CHROOT=$(find_binary chroot)
-    LIBPATH=":"
-    for bin in "$RM" "$INIT" "$CHROOT"; do
-       while read line; do
-           [[ $line =~ '(([^ ]*/lib[^/]*)/[^ ]*\.so[^ ]*)' ]] || continue
-           strstr "$LIBPATH" ":/sysroot${BASH_REMATCH[2]}:" || \
-               LIBPATH+="/sysroot${BASH_REMATCH[2]}:"
-           [[ ! $LDSO && ${BASH_REMATCH[1]} = */ld-linux*.so.* ]] && {
-               LDSO=${BASH_REMATCH[1]} 
-               LIBDIR="${LDSO%/*}"
-           }
-       done < <(ldd "$bin")
-    done
-    LIBPATH=${LIBPATH%:}; LIBPATH=${LIBPATH#:}
-    
-    sed -e "s,[@]RM[@],${RM}," \
-       -e "s,[@]INIT[@],${INIT}," \
-       -e "s,[@]CHROOT[@],${CHROOT}," \
-       -e "s,[@]LIBPATH[@],${LIBPATH}," \
-       -e "s,[@]LIBDIR[@],${LIBDIR}," \
-       -e "s,[@]LDSO[@],${LDSO}," <"$dsrc/switch_root.in" >"$dsrc/switch_root"
-    chmod 775 "$dsrc/switch_root"
-    inst "$dsrc/switch_root" /sbin/switch_root
-)
diff --git a/switch_root b/switch_root
new file mode 100755
index 0000000..ccb33c7
--- /dev/null
+++ b/switch_root
@@ -0,0 +1,75 @@
+#!/bin/sh
+# some utility functions
+
+# this is so we can scroll back.
+die() { echo "${1}, dying horribly."; while :;do read line; done }
+
+# jsut enough to get the job done
+simple_find() {
+    # $1 = file to look for
+    # $rest = places to look for it
+    local file=$1
+    shift
+    for loc in "$@"; do
+       [ -f "$NEWROOT$loc/$file" ] && { echo "$loc/$file"; return 0; }
+    done
+    return 1
+}
+
+# We really should not be doing this from here, but...
+find_interp() {
+    "$NEWROOT$CHROOT" "$NEWROOT" "$LDD" "$1" |while read interp rest; do
+       [ -f "${NEWROOT}$interp" ] || continue
+       echo "${NEWROOT}$interp"
+       return 0
+    done 
+    return 1
+}
+# start looking for required binaries and bits of infrastructure
+BINDIRS="/bin /sbin /usr/bin /usr/sbin"
+INITDIRS="/sbin /etc /"
+LIBPATH=":"
+LIBDIRS="$(echo $NEWROOT/lib* $NEWROOT/usr/lib*)"
+for x in $LIBDIRS; do
+    [ -d "$x" ] && LIBPATH="${LIBPATH}${x}:"
+done
+LIBPATH="${LIBPATH%:}"; LIBPATH="${LIBPATH#:}"
+[ "$LIBPATH" ] || die "Cannot find shared library diectories on $NEWROOT"
+RM=$(simple_find rm $BINDIRS) || die "Cannnot find rm on $NEWROOT"
+CHROOT=$(simple_find chroot $BINDIRS) || die "Cannot find chroot on $NEWROOT"
+INIT=$(simple_find init $INITDIRS) || die "Cannot find init on $NEWROOT"
+LDD=$(simple_find ldd $BINDIRS) || die "Cannot find ldd on $NEWROOT"
+
+# find the interpreters for the only two binaries we run totally from 
+# the real root fs without a chroot
+RM_LDSO=$(find_interp "$RM")
+CHROOT_LDSO=$(find_interp "$CHROOT")
+if [ -f "$RM_LDSO" ]; then
+    do_rm() { LD_LIBRARY_PATH="$LIBPATH" "$RM_LDSO" "$NEWROOT$RM" "$@"; }
+else
+    do_rm() { "$NEWROOT$RM" "$@"; }
+fi
+
+if [ -f "$CHROOT_LDSO" ];  then
+    do_switch() { exec "$CHROOT_LDSO" --library-path "$LIBPATH" "$NEWROOT$CHROO
+else
+    do_switch() { exec "$NEWROOT$CHROOT" "$NEWROOT" "$INIT"; }
+fi 
+
+# now, start the real process of switching the root
+cd /
+# kill udevd, move all our mounts over to the new root
+kill $(pidof udevd)
+mount --move /proc $NEWROOT/proc
+mount --move /sys $NEWROOT/sys
+mount --move /dev $NEWROOT/dev
+# redirect to new console. Our old initramfs will not be freed otherwise
+CONSOLE=$NEWROOT/dev/console
+[ -c $CONSOLE ] && exec >$CONSOLE 2>&1 <$CONSOLE
+for x in *; do
+    [ "/$x" = "$NEWROOT" ] && continue
+    do_rm -rf "$x"
+done
+# start running on the real root filesystem
+do_switch "$@"
+die "The chroot did not take for some reason"
diff --git a/switch_root.in b/switch_root.in
deleted file mode 100755
index 88548c7..0000000
--- a/switch_root.in
+++ /dev/null
@@ -1,30 +0,0 @@
-#!/bin/sh
-LIBDIR="${NEWROOT}@LIBDIR@"
-LDSO="${NEWROOT}@LDSO@"
-INIT="@INIT@"
-CHROOT="${NEWROOT}@CHROOT@"
-RM="${NEWROOT}@RM@"
-LIB="${LIBDIR##*/}"
-LIBPATH="@LIBPATH@"
-die() { echo "$1"; exit 1; }
-[ -d "$LIBDIR" ] || die "No /lib dir on $NEWROOT, dying horribly." 
-[ -f "$LDSO" ] || die "No library interpreter on $NEWROOT, dying horribly."
-[ -x "$NEWROOT/$INIT" ] || die "No init on $NEWROOT, dying horribly."
-[ -x "$CHROOT" ] || die "No chroot on $NEWROOT, dying horribly"
-[ -x "$RM" ] || die "No rm on $NEWROOT, dying horribly"
-cd /
-# kill udevd, move all our mounts over to the new root
-kill $(pidof udevd)
-mount --move /proc $NEWROOT/proc
-mount --move /sys $NEWROOT/sys
-mount --move /dev $NEWROOT/dev
-# redirect to new console. Our old initramfs will not be freed otherwise
-CONSOLE=$NEWROOT/dev/console
-[ -c $CONSOLE ] && exec >$CONSOLE 2>&1 <$CONSOLE
-# remove everything on the initramfs
-for x in *; do
-    [ "/$x" = "$NEWROOT" ] && continue
-    LD_LIBRARY_PATH="$LIBDIR" "$LDSO" "$RM" -rf "$x"
-done
-# start running on the real root filesystem
-exec "$LDSO" --library-path "$LIBPATH" "$CHROOT" "$NEWROOT" "$INIT" "$@"



--
To unsubscribe from this list: send the line "unsubscribe initramfs" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
