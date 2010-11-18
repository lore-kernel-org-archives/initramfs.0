From: "Harald Hoyer" <harald-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: [dracut GIT] branch, master, updated. b2415f4414e0a13a81c90b5356ec1a4b7a61468b
Date: Thu, 18 Nov 2010 12:03:22 +0000
Message-ID: <E1PJ3DG-0000Fd-9D@sfp-scmshell-3.v30.ch3.sourceforge.com>
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

The branch, master has been updated
       via  b2415f4414e0a13a81c90b5356ec1a4b7a61468b (commit)
       via  2eea164db733f4ee022c30b9221d5007ba1ec151 (commit)
      from  7a8a33b6cdcb7ae614f9fab4816d9b86b30af445 (commit)

Those revisions listed above that are new to this repository have
not appeared on any other notification email; so we list those
revisions in full, below.

- Log -----------------------------------------------------------------
commit b2415f4414e0a13a81c90b5356ec1a4b7a61468b
Author: Harald Hoyer <harald-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Date:   Thu Nov 18 12:28:21 2010 +0100

    base: use systemd-timestamp for RD_TIMESTAMP, if possible

diff --git a/modules.d/99base/init b/modules.d/99base/init
index 1c695c2..f79d102 100755
--- a/modules.d/99base/init
+++ b/modules.d/99base/init
@@ -76,8 +76,13 @@ RDDEBUG=""
 mount -t proc -o nosuid,noexec,nodev /proc /proc >/dev/null 2>&1
 mount -t sysfs -o nosuid,noexec,nodev /sys /sys >/dev/null 2>&1
 
-read RD_TIMESTAMP _tmp < /proc/uptime
-unset _tmp
+
+if [ -x /lib/systemd/systemd-timestamp ]; then
+    RD_TIMESTAMP=$(/lib/systemd/systemd-timestamp)
+else
+    read RD_TIMESTAMP _tmp < /proc/uptime
+    unset _tmp
+fi
 
 if [ ! -c /dev/ptmx ]; then
     # try to mount devtmpfs
diff --git a/modules.d/99base/install b/modules.d/99base/install
index 0435e32..57bf4bc 100755
--- a/modules.d/99base/install
+++ b/modules.d/99base/install
@@ -27,3 +27,4 @@ inst "$moddir/dracut-lib.sh" "/lib/dracut-lib.sh"
 inst_hook cmdline 10 "$moddir/parse-root-opts.sh"
 inst_hook cmdline 20 "$moddir/parse-blacklist.sh"
 mkdir -p "${initdir}/var/run"
+[ -x /lib/systemd/systemd-timestamp ] && inst /lib/systemd/systemd-timestamp
commit 2eea164db733f4ee022c30b9221d5007ba1ec151
Author: Harald Hoyer <harald-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Date:   Wed Nov 17 17:37:22 2010 +0100

    base/init: do not set umask
    
    somehow /dev/dri gets created with the wrong permissions
    https://bugzilla.redhat.com/show_bug.cgi?id=626559

diff --git a/modules.d/99base/init b/modules.d/99base/init
index ee67ae5..1c695c2 100755
--- a/modules.d/99base/init
+++ b/modules.d/99base/init
@@ -66,9 +66,6 @@ export PATH=/sbin:/bin:/usr/sbin:/usr/bin
 NEWROOT="/sysroot"
 
 trap "emergency_shell Signal caught!" 0
-# set umask
-OLD_UMASK=$(umask)
-umask 0007
 
 RDDEBUG=""
 . /lib/dracut-lib.sh
@@ -326,7 +323,6 @@ info "Switching root"
 
 wait_for_loginit
 
-umask $OLD_UMASK
 export PATH="$OLD_PATH"
 
 exec /sbin/switch_root "$NEWROOT" "$INIT" $initargs || {
-----------------------------------------------------------------------

Summary of changes:
 modules.d/99base/init    |   13 +++++++------
 modules.d/99base/install |    1 +
 2 files changed, 8 insertions(+), 6 deletions(-)


-- 
dracut - Initramfs generator using udev
