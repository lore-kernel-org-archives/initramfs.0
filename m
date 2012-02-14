From: Will Woods <wwoods-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: [PATCH 5/9] 90livenet: port to url-lib
Date: Tue, 14 Feb 2012 12:38:06 -0500
Message-ID: <1329241090-26908-6-git-send-email-wwoods@redhat.com>
References: <1329241090-26908-1-git-send-email-wwoods@redhat.com>
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1329241090-26908-1-git-send-email-wwoods-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

This makes the livenetroot module use url-lib for fetching its root
image/filesystem. There's also some minor tweaks for POSIX compliance.

Signed-off-by: Will Woods <wwoods-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
---
 modules.d/90livenet/livenetroot      |   37 ++++++++++-----------------------
 modules.d/90livenet/module-setup.sh  |   13 +-----------
 modules.d/90livenet/parse-livenet.sh |   19 ++++++++++-------
 3 files changed, 23 insertions(+), 46 deletions(-)

diff --git a/modules.d/90livenet/livenetroot b/modules.d/90livenet/livenetroot
index 1e8e34e..bc62760 100755
--- a/modules.d/90livenet/livenetroot
+++ b/modules.d/90livenet/livenetroot
@@ -1,41 +1,26 @@
 #!/bin/bash
 # livenetroot - fetch a live image from the network and run it
-#
-# TODO:
-# * HTTPS: arg to use --no-check-certificate with https (boo)
-#          args for --certificate, --ca-certificate
-# * NFS support?
 
 type getarg >/dev/null 2>&1 || . /lib/dracut-lib.sh
 [ -f /tmp/root.info ] && . /tmp/root.info
 
+. /lib/url-lib.sh
+
 PATH=/usr/sbin:/usr/bin:/sbin:/bin
 
 # args get passed from 40network/netroot
-netroot=$2
-
-liveurl=${netroot#livenet:}
-
-if [ ${liveurl##*.} == "iso" ]; then
-    imgfile="/run/live.iso"
-else
-    imgfile="/run/rootfs.img"
-fi
-
-
-case "$liveurl" in
-  http://*|https://*|ftp://*)
-    wget -O $imgfile "$liveurl"
-  ;;
-  *) die "don't know how to handle URL: $liveurl" ;;
-esac
-[ $? == 0 ] || die "failed to download live image"
-
-
-if [ ${imgfile##*.} == "iso" ]; then
+netroot="$2"
+liveurl="${netroot#livenet:}"
+info "fetching $liveurl"
+imgfile=$(fetch_url "$liveurl")
+[ $? = 0 ] || die "failed to download live image: error $?"
+
+# TODO: couldn't dmsquash-live-root handle this?
+if [ ${imgfile##*.} = "iso" ]; then
     root=$(losetup -f)
     losetup $root $imgfile
 else
     root=$imgfile
 fi
+
 exec /sbin/dmsquash-live-root $root
diff --git a/modules.d/90livenet/module-setup.sh b/modules.d/90livenet/module-setup.sh
index 5cfbb75..31164fd 100755
--- a/modules.d/90livenet/module-setup.sh
+++ b/modules.d/90livenet/module-setup.sh
@@ -2,26 +2,15 @@
 # module-setup.sh for livenet
 
 check() {
-    # a live, host-only image doesn't really make a lot of sense
-    [[ $hostonly ]] && return 1
-    command -v wget >/dev/null || return 1
     return 255
 }
 
 depends() {
-    echo network dmsquash-live
+    echo network url-lib dmsquash-live
     return 0
 }
 
 install() {
-    dracut_install wget
-    mkdir -m 0755 -p "$initdir/etc/ssl/certs"
-    if ! inst_any -t /etc/ssl/certs/ca-bundle.crt \
-            /etc/ssl/certs/ca-bundle.crt \
-            /etc/ssl/certs/ca-certificates.crt; then
-        dwarn "Couldn't find SSL CA cert bundle; HTTPS won't work."
-    fi
-
     inst_hook cmdline 29 "$moddir/parse-livenet.sh"
     inst "$moddir/livenetroot" "/sbin/livenetroot"
 }
diff --git a/modules.d/90livenet/parse-livenet.sh b/modules.d/90livenet/parse-livenet.sh
index 2e6bc4b..042cc51 100755
--- a/modules.d/90livenet/parse-livenet.sh
+++ b/modules.d/90livenet/parse-livenet.sh
@@ -3,17 +3,20 @@
 # root=live:[url-to-backing-file]
 
 [ -z "$root" ] && root=$(getarg root=)
+. /lib/url-lib.sh
 
-str_starts $root "live:" && liveurl=$root
-str_starts $liveurl "live:" || return
+str_starts "$root" "live:" && liveurl="$root"
+str_starts "$liveurl" "live:" || return
 liveurl="${liveurl#live:}"
 
 # setting netroot to "livenet:..." makes "livenetroot" get run after ifup
-case "$liveurl" in
-    http://*|https://*|ftp://*)
-        netroot="livenet:$liveurl"
-        root="livenet" # quiet complaints from init
-        rootok=1 ;;
-esac
+if get_url_handler "$liveurl" >/dev/null; then
+    info "livenet: root image at $liveurl"
+    netroot="livenet:$liveurl"
+    root="livenet" # quiet complaints from init
+    rootok=1
+else
+    info "livenet: no url handler for $liveurl"
+fi
 
 wait_for_dev /dev/root
-- 
1.7.7.6
