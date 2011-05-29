From: Michal Soltys <soltys-R61QfzASbfY@public.gmane.org>
Subject: [RFC] fstab-sys: concept
Date: Sun, 29 May 2011 02:38:29 +0200
Message-ID: <1306629509-8326-1-git-send-email-soltys@ziu.info>
References: <20110525143311.GA14298@nb.net.home>
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20110525143311.GA14298-sHeGUpI7y9L/9pzu0YdTqQ@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: kzak-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org, harald.hoyer-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org

This is a concept of how the fstab.sys could be implemented. The "trickery"
relies on using /bin/echo (so we can handle octal codes and to guarantee echo
-e is actually functional) and \v as a field separator, which is unlikely to be
ever used in practice...

fstab-sys would consist of cmdline hook:

- producing initqueue/finished check for all the /dev/* stuff
- producing \v separated description of what to fsck later and what to
  mount

and pre-pivot hook:

- fscking in parallel per pass
- specially handling xfs (perhaps others ?)
- mounting

If such approach is fine, I'll turn it into usable form, along with
det_fs/wrap_fsck updates.

---
 modules.d/95fstab-sys/module-setup.sh        |   12 ++++-
 modules.d/95fstab-sys/parse-fstab-sys.sh     |   59 ++++++++++++++++++++++++++
 modules.d/95fstab-sys/pre-pivot-fstab-sys.sh |   45 +++++++++++++++++++
 3 files changed, 113 insertions(+), 3 deletions(-)
 create mode 100755 modules.d/95fstab-sys/parse-fstab-sys.sh
 create mode 100755 modules.d/95fstab-sys/pre-pivot-fstab-sys.sh

diff --git a/modules.d/95fstab-sys/module-setup.sh b/modules.d/95fstab-sys/module-setup.sh
index 1fbd55b..f514571 100755
--- a/modules.d/95fstab-sys/module-setup.sh
+++ b/modules.d/95fstab-sys/module-setup.sh
@@ -7,12 +7,18 @@ check() {
 }
 
 depends() {
+    # echo fs-lib
     return 0
 }
 
 install() {
+    # will be moved away to fs-lib
+    # dracut_install /sbin/fsck*
+    # type -P e2fsck >/dev/null && dracut_install e2fsck
+    # +xfs stuff
+
     dracut_install /etc/fstab.sys
-    dracut_install /sbin/fsck*
-    type -P e2fsck >/dev/null && dracut_install e2fsck
-    inst_hook pre-pivot 00 "$moddir/mount-sys.sh"
+    dracut_install echo
+    inst_hook cmdline 10 "$moddir/parse-fstab-sys.sh"
+    inst_hook pre-pivot 00 "$moddir/pre-pivot-fstab-sys.sh"
 }
diff --git a/modules.d/95fstab-sys/parse-fstab-sys.sh b/modules.d/95fstab-sys/parse-fstab-sys.sh
new file mode 100755
index 0000000..4847766
--- /dev/null
+++ b/modules.d/95fstab-sys/parse-fstab-sys.sh
@@ -0,0 +1,59 @@
+#!/bin/sh
+# -*- mode: shell-script; indent-tabs-mode: nil; sh-basic-offset: 4; -*-
+# ex: ts=8 sw=4 sts=4 et filetype=sh
+
+type getarg >/dev/null 2>&1 || . /lib/dracut-lib.sh
+
+local _dev _mp _fs _opts _dump _pass _rest _fsck
+
+while read _dev _mp _fs _opts _dump _pass _rest; do
+    [ -z "${_dev%%#*}" ] && continue # Skip comment lines
+
+    # handling block: is an overkill, but let's be consistent
+    # a little trickery - we will use \v as a separator to simplify our
+    # life; whole stuff will of course break, if someone actually uses that
+    # in fstab.sys ...
+
+    # parse special stuff
+    _dev=$(/bin/echo -en "$_dev")
+    _mp=$(/bin/echo -en "$_mp")
+    _opts=$(/bin/echo -en "$_opts")
+    _fs=$(/bin/echo -en "$_fs")
+    [ "$_pass" -gt 0 ] && _fsck="$_pass" || _fsck=0
+
+    case "$_dev" in
+        block:LABEL=*|LABEL=*)
+        _dev="${_dev#block:}"
+        _dev="$(echo -n "$_dev" | sed 's,/,\\x2f,g')"
+        _dev="/dev/disk/by-label/${_dev#LABEL=}"
+        ;;
+        block:UUID=*|UUID=*)
+        _dev="${_dev#block:}"
+        _dev="/dev/disk/by-uuid/${_dev#UUID=}"
+        ;;
+    esac
+
+    # allow only actual /dev devices to be waited for and fscked
+    if [ -z "${_dev#/dev/*}" ]; then
+        echo "[ -b \"$_dev\" ] || return 1" >>/tmp/fstab-sys.sh
+    else
+        _fsck=0
+    fi
+
+    # prepare "compiled" fstab we will use later
+    /bin/echo -e "$_dev\v$_mp\v\$_fs\v$_opts" >>/tmp/fstab-sys.compiled
+
+    # export fsck passes
+    # don't bother with printf to handle $_fsck > 9 alignment,
+    # but verify that in module-setup.sh
+    if [ "$_fsck" -gt 0 ]; then
+        /bin/echo "$_dev\v$_fs" >>/tmp/fstab-sys.pass.$_fsck
+    fi
+
+done </etc/fstab.sys
+
+# add initqueue/finished, only if there's something to add though
+if [ -e /tmp/fstab-sys.sh ]; then
+    echo "return 0" >>/tmp/fstab-sys.sh
+    mv /tmp/fstab-sys.sh $hookdir/initqueue/finished/fstab-sys.sh
+fi
diff --git a/modules.d/95fstab-sys/pre-pivot-fstab-sys.sh b/modules.d/95fstab-sys/pre-pivot-fstab-sys.sh
new file mode 100755
index 0000000..1a4b9b7
--- /dev/null
+++ b/modules.d/95fstab-sys/pre-pivot-fstab-sys.sh
@@ -0,0 +1,45 @@
+#!/bin/sh
+# -*- mode: shell-script; indent-tabs-mode: nil; sh-basic-offset: 4; -*-
+# ex: ts=8 sw=4 sts=4 et filetype=sh
+
+type getarg >/dev/null 2>&1 || . /lib/dracut-lib.sh
+
+local _dev _mp _fs _opts _auto _manual _oldIFS _x
+
+oldIFS="$IFS"
+IFS=$(/bin/echo -ne "\v")
+
+# fsck pass
+_manual=
+for _x in /tmp/fstab-sys.pass.[0-9]; do
+    _auto=
+    while read _dev _fs; do
+        _fs=$(IFS="$oldIFS" det_fs "$_dev" "$_fs" "fstab-sys")
+        if [ $_fs = xfs ]; then
+            # xfs is special, so treat is specially ;)
+            _manual=$(/bin/echo -e "${_manual:+${_manual}\v}$_dev")
+            continue
+        fi
+        _auto=$(/bin/echo -e "${_auto:+${_auto}\v}$_dev")
+    done <$_x
+    # use updated wrap_fsck in full version
+    fsck -M -T $_auto
+done
+
+# special fsck pass for xfs and perhaps others
+for _dev in $_manual; do
+    # use updated wrap_fsck in full version
+    if ! xfs_check "$_dev"; then
+        warn "*** XFS on '$_dev' is damaged, please assist."
+        emergency_shell -n "(Repair filesystem)"
+    fi
+done
+
+# mount pass
+while read _dev _mp _fs _opts; do
+    _fs=$(IFS="$oldIFS" det_fs "$_dev" "$_fs" "fstab-sys")
+    info "Mounting $_dev"
+    mount -v -t "$_fs" -o "$_opts" "$_dev" "$NEWROOT/$_mp" 2>&1 | vinfo
+done </tmp/fstab-sys.compiled
+
+IFS="$_oldIFS"
-- 
1.7.4.2
