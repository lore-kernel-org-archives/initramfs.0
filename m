From: "Harald Hoyer" <harald-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: [dracut GIT] branch, master, updated. 5023964844530eebef6fb779320b09472ef1d8d7
Date: Thu, 11 Nov 2010 10:10:48 +0000
Message-ID: <E1PGU7R-00087t-I8@sfp-scmshell-1.v30.ch3.sourceforge.com>
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

The branch, master has been updated
       via  5023964844530eebef6fb779320b09472ef1d8d7 (commit)
       via  4af673c3f8626872f1f638e4df2c6fab9a0d45ef (commit)
      from  5dc6f240856a37d864298e67233a8312c882a927 (commit)

Those revisions listed above that are new to this repository have
not appeared on any other notification email; so we list those
revisions in full, below.

- Log -----------------------------------------------------------------
commit 5023964844530eebef6fb779320b09472ef1d8d7
Author: Harald Hoyer <harald-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Date:   Thu Nov 11 10:56:26 2010 +0100

    move initlog.pipe to /dev/.initramfs

diff --git a/modules.d/40network/dhclient-script b/modules.d/40network/dhclient-script
index 4b566d0..81917e0 100755
--- a/modules.d/40network/dhclient-script
+++ b/modules.d/40network/dhclient-script
@@ -47,7 +47,7 @@ setup_interface() {
 PATH=$PATH:/sbin:/usr/sbin
 
 export PS4="dhclient.$interface.$$ + "
-exec >>/dev/initlog.pipe 2>>/dev/initlog.pipe
+exec >>/dev/.initramfs/initlog.pipe 2>>/dev/.initramfs/initlog.pipe
 . /lib/dracut-lib.sh
 
 # We already need a set netif here
diff --git a/modules.d/40network/ifup b/modules.d/40network/ifup
index 73e7984..c548ece 100755
--- a/modules.d/40network/ifup
+++ b/modules.d/40network/ifup
@@ -83,7 +83,7 @@ do_static() {
 PATH=$PATH:/sbin:/usr/sbin
 
 export PS4="ifup.$1.$$ + "
-exec >>/dev/initlog.pipe 2>>/dev/initlog.pipe
+exec >>/dev/.initramfs/initlog.pipe 2>>/dev/.initramfs/initlog.pipe
 . /lib/dracut-lib.sh
 
 # Huh? No $1?
diff --git a/modules.d/95fcoe/fcoe-up b/modules.d/95fcoe/fcoe-up
index 4607507..b4eaa09 100755
--- a/modules.d/95fcoe/fcoe-up
+++ b/modules.d/95fcoe/fcoe-up
@@ -14,7 +14,7 @@ PATH=$PATH:/sbin:/usr/sbin
 [ -z "$1" -o -z "$2" ] && exit 1
 
 export PS4="fcoe-up.$1.$$ + "
-exec >>/dev/initlog.pipe 2>>/dev/initlog.pipe
+exec >>/dev/.initramfs/initlog.pipe 2>>/dev/.initramfs/initlog.pipe
 . /lib/dracut-lib.sh
 
 netif=$1
diff --git a/modules.d/99base/init b/modules.d/99base/init
index bc5dc7f..ee67ae5 100755
--- a/modules.d/99base/init
+++ b/modules.d/99base/init
@@ -33,6 +33,7 @@ wait_for_loginit()
         done
         set -x
     fi
+    rm -f /dev/.initramfs/initlog.pipe
 }
 
 emergency_shell()
@@ -105,9 +106,9 @@ mount -t tmpfs -o mode=1777,noexec,nosuid,nodev  tmpfs /dev/shm >/dev/null 2>&1
 
 if getargbool 0 rd.debug -y rdinitdebug -y rdnetdebug; then
     getarg quiet && DRACUT_QUIET="yes"
-    mkfifo /dev/initlog.pipe
-    /sbin/loginit $DRACUT_QUIET </dev/initlog.pipe >/dev/console 2>&1 &
-    exec >/dev/initlog.pipe 2>&1
+    mkfifo /dev/.initramfs/initlog.pipe
+    /sbin/loginit $DRACUT_QUIET </dev/.initramfs/initlog.pipe >/dev/console 2>&1 &
+    exec >/dev/.initramfs/initlog.pipe 2>&1
 else
     exec 0<>/dev/console 1<>/dev/console 2<>/dev/console
 fi
commit 4af673c3f8626872f1f638e4df2c6fab9a0d45ef
Author: Harald Hoyer <harald-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Date:   Thu Nov 11 10:58:38 2010 +0100

    base/init: merge mkdir and add more mount options

diff --git a/modules.d/99base/init b/modules.d/99base/init
index ef96918..bc5dc7f 100755
--- a/modules.d/99base/init
+++ b/modules.d/99base/init
@@ -75,17 +75,17 @@ RDDEBUG=""
 [ -c /dev/null ] || mknod -m 0666 /dev/null c 1 3
 
 # mount some important things
-mount -t proc /proc /proc >/dev/null 2>&1
-mount -t sysfs /sys /sys >/dev/null 2>&1
+mount -t proc -o nosuid,noexec,nodev /proc /proc >/dev/null 2>&1
+mount -t sysfs -o nosuid,noexec,nodev /sys /sys >/dev/null 2>&1
 
 read RD_TIMESTAMP _tmp < /proc/uptime
 unset _tmp
 
 if [ ! -c /dev/ptmx ]; then
     # try to mount devtmpfs
-    if ! mount -t devtmpfs -omode=0755 udev /dev >/dev/null 2>&1; then
+    if ! mount -t devtmpfs -o mode=0755,nosuid udev /dev >/dev/null 2>&1; then
         # if it failed fall back to normal tmpfs
-        mount -t tmpfs -omode=0755 udev /dev >/dev/null 2>&1 
+        mount -t tmpfs -o mode=0755,nosuid udev /dev >/dev/null 2>&1 
         # Make some basic devices first, let udev handle the rest
         mknod -m 0666 /dev/null c 1 3
         mknod -m 0666 /dev/ptmx c 5 2
@@ -94,10 +94,14 @@ if [ ! -c /dev/ptmx ]; then
     fi
 fi
 
+# prepare the /dev directory
 ln -s /proc/self/fd /dev/fd >/dev/null 2>&1
 ln -s /proc/self/fd/0 /dev/stdin >/dev/null 2>&1
 ln -s /proc/self/fd/1 /dev/stdout >/dev/null 2>&1
 ln -s /proc/self/fd/2 /dev/stderr >/dev/null 2>&1
+mkdir -m 0755 /dev/shm /dev/pts /dev/.udev /dev/.udev/rules.d /dev/.initramfs
+mount -t devpts -o gid=5,mode=620,noexec,nosuid devpts /dev/pts >/dev/null 2>&1
+mount -t tmpfs -o mode=1777,noexec,nosuid,nodev  tmpfs /dev/shm >/dev/null 2>&1
 
 if getargbool 0 rd.debug -y rdinitdebug -y rdnetdebug; then
     getarg quiet && DRACUT_QUIET="yes"
@@ -110,11 +114,6 @@ fi
 
 setdebug
 
-mkdir /dev/shm /dev/pts 
-mkdir -p -m 0755 /dev/.udev/rules.d
-mount -t devpts -o gid=5,mode=620 devpts /dev/pts >/dev/null 2>&1
-mount -t tmpfs tmpfs /dev/shm >/dev/null 2>&1
-
 UDEVVERSION=$(udevadm --version)
 
 source_conf /etc/conf.d
@@ -313,7 +312,6 @@ fi
 
 # Debug: Copy state
 if getargbool 0 rd.copystate -y rdcopystate; then
-    mkdir -p /dev/.initramfs
     cp /tmp/* /dev/.initramfs/ >/dev/null 2>&1
 fi
 
-----------------------------------------------------------------------

Summary of changes:
 modules.d/40network/dhclient-script |    2 +-
 modules.d/40network/ifup            |    2 +-
 modules.d/95fcoe/fcoe-up            |    2 +-
 modules.d/99base/init               |   25 ++++++++++++-------------
 4 files changed, 15 insertions(+), 16 deletions(-)


-- 
dracut - Initramfs generator using udev
