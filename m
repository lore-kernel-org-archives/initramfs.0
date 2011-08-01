From: Will Woods <wwoods-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: [PATCH] livenet: module for fetching live images from the network
Date: Mon,  1 Aug 2011 16:22:40 -0400
Message-ID: <1312230160-11295-1-git-send-email-wwoods@redhat.com>
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

The livenet module allows you to use a root arg like:

    root=http://server.name/path/to/live.img ip=dhcp

The named live image will be downloaded with wget and then set up as the
root device.

It currently supports FTP, HTTP, and HTTPS. dracut will try to install
the CA bundle (/etc/ssl/certs/ca-bundle.crt) into the initramfs so that
SSL certificate checking will work properly.

If an HTTPS URL is given and the site fails the certificate check, the
file will be rejected and the system will not boot into it.

Signed-off-by: Will Woods <wwoods-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
---
 modules.d/90livenet/livenetroot      |   41 ++++++++++++++++++++++++++++++++++
 modules.d/90livenet/module-setup.sh  |   25 ++++++++++++++++++++
 modules.d/90livenet/parse-livenet.sh |   19 +++++++++++++++
 3 files changed, 85 insertions(+), 0 deletions(-)
 create mode 100755 modules.d/90livenet/livenetroot
 create mode 100755 modules.d/90livenet/module-setup.sh
 create mode 100755 modules.d/90livenet/parse-livenet.sh

diff --git a/modules.d/90livenet/livenetroot b/modules.d/90livenet/livenetroot
new file mode 100755
index 0000000..1e8e34e
--- /dev/null
+++ b/modules.d/90livenet/livenetroot
@@ -0,0 +1,41 @@
+#!/bin/bash
+# livenetroot - fetch a live image from the network and run it
+#
+# TODO:
+# * HTTPS: arg to use --no-check-certificate with https (boo)
+#          args for --certificate, --ca-certificate
+# * NFS support?
+
+type getarg >/dev/null 2>&1 || . /lib/dracut-lib.sh
+[ -f /tmp/root.info ] && . /tmp/root.info
+
+PATH=/usr/sbin:/usr/bin:/sbin:/bin
+
+# args get passed from 40network/netroot
+netroot=$2
+
+liveurl=${netroot#livenet:}
+
+if [ ${liveurl##*.} == "iso" ]; then
+    imgfile="/run/live.iso"
+else
+    imgfile="/run/rootfs.img"
+fi
+
+
+case "$liveurl" in
+  http://*|https://*|ftp://*)
+    wget -O $imgfile "$liveurl"
+  ;;
+  *) die "don't know how to handle URL: $liveurl" ;;
+esac
+[ $? == 0 ] || die "failed to download live image"
+
+
+if [ ${imgfile##*.} == "iso" ]; then
+    root=$(losetup -f)
+    losetup $root $imgfile
+else
+    root=$imgfile
+fi
+exec /sbin/dmsquash-live-root $root
diff --git a/modules.d/90livenet/module-setup.sh b/modules.d/90livenet/module-setup.sh
new file mode 100755
index 0000000..39cedcc
--- /dev/null
+++ b/modules.d/90livenet/module-setup.sh
@@ -0,0 +1,25 @@
+#!/bin/bash
+# module-setup.sh for livenet
+
+check() {
+    # a live, host-only image doesn't really make a lot of sense
+    [[ $hostonly ]] && return 1
+    return 0
+}
+
+depends() {
+    echo network dmsquash-live
+    return 0
+}
+
+install() {
+    dracut_install wget
+    mkdir -m 0755 -p "$initdir/etc/ssl/certs"
+    if ! inst /etc/ssl/certs/ca-bundle.crt; then
+        dwarn "Couldn't find SSL CA cert bundle; HTTPS won't work."
+    fi
+
+    inst_hook cmdline 30 "$moddir/parse-livenet.sh"
+    inst "$moddir/livenetroot" "/sbin/livenetroot"
+}
+
diff --git a/modules.d/90livenet/parse-livenet.sh b/modules.d/90livenet/parse-livenet.sh
new file mode 100755
index 0000000..78fc906
--- /dev/null
+++ b/modules.d/90livenet/parse-livenet.sh
@@ -0,0 +1,19 @@
+#!/bin/bash
+# live net images - just like live images, but specified like:
+# root=live:[url-to-backing-file]
+
+[ -z "$root" ] && root=$(getarg root=)
+
+str_starts $root "live:" && liveurl=$root
+str_starts $liveurl "live:" || return
+liveurl="${liveurl#live:}"
+
+# setting netroot to "livenet:..." makes "livenetroot" get run after ifup
+case "$liveurl" in
+    http://*|https://*|ftp://*)
+        netroot="livenet:$liveurl"
+        rootok=1 ;;
+esac
+
+root="livenet" # quiet complaints from init
+echo '[ -e /dev/root ]' > $hookdir/initqueue/finished/livenet.sh
-- 
1.7.6
