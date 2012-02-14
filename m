From: Will Woods <wwoods-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: [PATCH 7/9] add set_http_header to url-lib
Date: Tue, 14 Feb 2012 12:38:08 -0500
Message-ID: <1329241090-26908-8-git-send-email-wwoods@redhat.com>
References: <1329241090-26908-1-git-send-email-wwoods@redhat.com>
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1329241090-26908-1-git-send-email-wwoods-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

This allows you to set custom headers for curl to send with HTTP
requests.

Signed-off-by: Will Woods <wwoods-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
---
 modules.d/45url-lib/url-lib.sh |   34 +++++++++++++++++++++++++++++-----
 1 files changed, 29 insertions(+), 5 deletions(-)

diff --git a/modules.d/45url-lib/url-lib.sh b/modules.d/45url-lib/url-lib.sh
index 03ee8d1..dd473d4 100755
--- a/modules.d/45url-lib/url-lib.sh
+++ b/modules.d/45url-lib/url-lib.sh
@@ -51,6 +51,8 @@ add_url_handler() {
 
 ### HTTP, HTTPS, FTP #################################################
 
+export CURL_HOME="/run/initramfs/url-lib"
+mkdir -p $CURL_HOME
 curl_args="--location --retry 3 --fail --show-error"
 curl_fetch_url() {
     local url="$1" outloc="$2"
@@ -69,19 +71,41 @@ curl_fetch_url() {
 }
 add_url_handler curl_fetch_url http https ftp
 
+set_http_header() {
+    echo "header = \"$1: $2\"" >> $CURL_HOME/.curlrc
+}
+
 ### NFS ##############################################################
 
 . /lib/nfs-lib.sh
 
+nfs_already_mounted() {
+    local server="$1" path="$2" localdir="" s="" p=""
+    cat /proc/mounts | while read src mnt rest; do
+        splitsep ":" "$src" s p
+        if [ "$server" = "$s" ]; then
+            if [ "$path" = "$p" ]; then
+                echo $mnt
+            elif str_starts "$path" "$p"; then
+                echo $mnt/${path#$p/}
+            fi
+        fi
+    done
+}
+
 nfs_fetch_url() {
     local url="$1" outloc="$2" nfs="" server="" path="" options=""
     nfs_to_var "$url" || return 255
-    local filepath="${path%/*}" filename="${path##*/}"
+    local filepath="${path%/*}" filename="${path##*/}" mntdir=""
 
-    # TODO: check to see if server:/filepath is already mounted
-    local mntdir="$(mkuniqdir /run nfs_mnt)"
-    mount_nfs $nfs:$server:$path${options:+:$options} $mntdir
-    # FIXME: schedule lazy unmount during pre-pivot hook
+    # skip mount if server:/filepath is already mounted
+    mntdir=$(nfs_already_mounted $server $path)
+    if [ -z "$mntdir" ]; then
+        local mntdir="$(mkuniqdir /run nfs_mnt)"
+        mount_nfs $nfs:$server:$path${options:+:$options} $mntdir
+        # lazy unmount during pre-pivot hook
+        inst_hook --hook pre-pivot --name 99url-lib-umount-nfs umount -l $mntdir
+    fi
 
     if [ -z "$outloc" ]; then
         outloc="$mntdir/$filename"
-- 
1.7.7.6
