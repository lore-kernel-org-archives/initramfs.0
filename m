From: Will Woods <wwoods-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: [PATCH 7/7] Add support for in-initramfs live images with "root=live:/path/name.img"
Date: Tue,  8 Mar 2011 18:35:17 -0500
Message-ID: <1299627317-11145-8-git-send-email-wwoods@redhat.com>
References: <1299627317-11145-1-git-send-email-wwoods@redhat.com>
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1299627317-11145-1-git-send-email-wwoods-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

This allows creation of initramfs images which contain a Live system.
The primary use for this is keeping very large initramfs-based systems
(e.g. anaconda, the Fedora installer) compressed in-memory, by using a
compressed filesystem image like squashfs or btrfs.

dmsquash-live-genrules.sh will initqueue dmsquash-live-root itself
(rather than making udev rules) if the given live "device" is actually
an existing, plain file.

parse-dmsquash-live.sh will only accept paths that end in ".img".
dmsquash-live-root will only handle images named "*squashfs.img",
"*ext3fs.img", or "*btrfs.img".
---
 .../90dmsquash-live/dmsquash-live-genrules.sh      |   12 ++++++++++--
 modules.d/90dmsquash-live/dmsquash-live-root       |   18 +++++++++++++-----
 modules.d/90dmsquash-live/parse-dmsquash-live.sh   |    2 ++
 3 files changed, 25 insertions(+), 7 deletions(-)

diff --git a/modules.d/90dmsquash-live/dmsquash-live-genrules.sh b/modules.d/90dmsquash-live/dmsquash-live-genrules.sh
index 72695a9..5642d53 100755
--- a/modules.d/90dmsquash-live/dmsquash-live-genrules.sh
+++ b/modules.d/90dmsquash-live/dmsquash-live-genrules.sh
@@ -1,7 +1,8 @@
 #!/bin/sh
 # -*- mode: shell-script; indent-tabs-mode: nil; sh-basic-offset: 4; -*-
 # ex: ts=8 sw=4 sts=4 et filetype=sh
-if [ "${root%%:*}" = "live" ]; then
+case "$root" in
+  live:/dev/*)
     {
         printf 'KERNEL=="%s", SYMLINK+="live"\n' \
             ${root#live:/dev/} 
@@ -15,4 +16,11 @@ if [ "${root%%:*}" = "live" ]; then
             ${root#live:/dev/} 
     } >> /etc/udev/rules.d/99-live-squash.rules
     echo '[ -e /dev/root ]' > /initqueue-finished/dmsquash.sh
-fi
+  ;;
+  live:*)
+    if [ -f "${root#live:}" ]; then
+        /sbin/initqueue --settled --onetime --unique /sbin/dmsquash-live-root "${root#live:}"
+        echo '[ -e /dev/root ]' > /initqueue-finished/dmsquash.sh
+    fi
+  ;;
+esac
diff --git a/modules.d/90dmsquash-live/dmsquash-live-root b/modules.d/90dmsquash-live/dmsquash-live-root
index f8aa805..c857e48 100755
--- a/modules.d/90dmsquash-live/dmsquash-live-root
+++ b/modules.d/90dmsquash-live/dmsquash-live-root
@@ -44,11 +44,19 @@ getarg rw && liverw=rw
 [ -z "$liverw" ] && liverw=ro
 # mount the backing of the live image first
 mkdir -p /dev/.initramfs/live
-mount -n -t $fstype -o $liverw $livedev /dev/.initramfs/live
-RES=$?
-if [ "$RES" != "0" ]; then
-    die "Failed to mount block device of live image"
-    exit 1
+if [ -f $livedev ]; then
+    # no mount needed - we've already got the LiveOS image in initramfs
+    case $livedev in
+        *squashfs.img) SQUASHED=$livedev ;;
+        *ext3fs.img|*btrfs.img) FSIMG=$livedev ;;
+    esac
+else
+    mount -n -t $fstype -o $liverw $livedev /dev/.initramfs/live
+    RES=$?
+    if [ "$RES" != "0" ]; then
+        die "Failed to mount block device of live image"
+        exit 1
+    fi
 fi
 
 # overlay setup helper function
diff --git a/modules.d/90dmsquash-live/parse-dmsquash-live.sh b/modules.d/90dmsquash-live/parse-dmsquash-live.sh
index 38610fb..6e0db29 100755
--- a/modules.d/90dmsquash-live/parse-dmsquash-live.sh
+++ b/modules.d/90dmsquash-live/parse-dmsquash-live.sh
@@ -38,6 +38,8 @@ case "$liveroot" in
         rootok=1 ;;
     live:/dev/*)
         rootok=1 ;;
+    live:/*.[Ii][Mm][Gg]|/*.[Ii][Mm][Gg])
+        [ -f "${root#live:}" ] && rootok=1 ;;
 esac
 info "root was $root, liveroot is now $liveroot"
 
-- 
1.7.4
