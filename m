From: Will Woods <wwoods-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: [PATCH 6/9] url-lib: add support for NFS
Date: Tue, 14 Feb 2012 12:38:07 -0500
Message-ID: <1329241090-26908-7-git-send-email-wwoods@redhat.com>
References: <1329241090-26908-1-git-send-email-wwoods@redhat.com>
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1329241090-26908-1-git-send-email-wwoods-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

This adds nfs_fetch_url to allow fetching arbitrary files from NFS.

This means that livenet can now run using an NFS-mounted live image,
which reduces memory usage by a lot.

Signed-off-by: Will Woods <wwoods-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
---
 modules.d/45url-lib/url-lib.sh |   28 ++++++++++++++++++++++++++++
 1 files changed, 28 insertions(+), 0 deletions(-)

diff --git a/modules.d/45url-lib/url-lib.sh b/modules.d/45url-lib/url-lib.sh
index 51340d5..03ee8d1 100755
--- a/modules.d/45url-lib/url-lib.sh
+++ b/modules.d/45url-lib/url-lib.sh
@@ -10,6 +10,8 @@ type mkuniqdir >/dev/null 2>&1 || . /lib/dracut-lib.sh
 #   fetch the given URL to a locally-visible location.
 #   if OUTFILE is given, the URL will be fetched to that filename,
 #   overwriting it if present.
+#   If the URL is something mountable (e.g. nfs://) and no OUTFILE is given,
+#   the server will be left mounted until pre-pivot.
 #   the return values are as follows:
 #   0: success
 #   253: unknown error (file missing)
@@ -47,6 +49,8 @@ add_url_handler() {
     url_handler_map="$@"
 }
 
+### HTTP, HTTPS, FTP #################################################
+
 curl_args="--location --retry 3 --fail --show-error"
 curl_fetch_url() {
     local url="$1" outloc="$2"
@@ -64,3 +68,27 @@ curl_fetch_url() {
     echo "$outloc"
 }
 add_url_handler curl_fetch_url http https ftp
+
+### NFS ##############################################################
+
+. /lib/nfs-lib.sh
+
+nfs_fetch_url() {
+    local url="$1" outloc="$2" nfs="" server="" path="" options=""
+    nfs_to_var "$url" || return 255
+    local filepath="${path%/*}" filename="${path##*/}"
+
+    # TODO: check to see if server:/filepath is already mounted
+    local mntdir="$(mkuniqdir /run nfs_mnt)"
+    mount_nfs $nfs:$server:$path${options:+:$options} $mntdir
+    # FIXME: schedule lazy unmount during pre-pivot hook
+
+    if [ -z "$outloc" ]; then
+        outloc="$mntdir/$filename"
+    else
+        cp -f "$mntdir/$filename" "$outloc" || return $?
+    fi
+    [ -f "$outloc" ] || return 253
+    echo "$outloc"
+}
+add_url_handler nfs_fetch_url nfs nfs4
-- 
1.7.7.6
