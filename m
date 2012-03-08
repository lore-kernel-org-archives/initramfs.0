From: Will Woods <wwoods-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: [PATCH] url-lib: clean up output
Date: Thu,  8 Mar 2012 18:03:39 -0500
Message-ID: <1331247819-12140-1-git-send-email-wwoods@redhat.com>
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

For curl_fetch_url (http/https/ftp):
- use --progress-bar (the output is less messy)
- print the URL we're fetching so the user know's what's happening

For curl and nfs:
- don't echo the filename if it was provided by the user
---
 modules.d/45url-lib/url-lib.sh |    7 ++++---
 1 files changed, 4 insertions(+), 3 deletions(-)

diff --git a/modules.d/45url-lib/url-lib.sh b/modules.d/45url-lib/url-lib.sh
index 043a700..e305a68 100755
--- a/modules.d/45url-lib/url-lib.sh
+++ b/modules.d/45url-lib/url-lib.sh
@@ -53,9 +53,10 @@ add_url_handler() {
 
 export CURL_HOME="/run/initramfs/url-lib"
 mkdir -p $CURL_HOME
-curl_args="--location --retry 3 --fail --show-error"
+curl_args="--location --retry 3 --fail --show-error --progress-bar"
 curl_fetch_url() {
     local url="$1" outloc="$2"
+    echo "$url" > /proc/self/fd/0
     if [ -n "$outloc" ]; then
         curl $curl_args --output "$outloc" "$url" || return $?
     else
@@ -64,7 +65,7 @@ curl_fetch_url() {
         outloc="$outdir/$(ls -A $outdir)"
     fi
     [ -f "$outloc" ] || return 253
-    echo "$outloc"
+    if [ -z "$2" ]; then echo "$outloc" ; fi
 }
 add_url_handler curl_fetch_url http https ftp
 
@@ -110,6 +111,6 @@ nfs_fetch_url() {
         cp -f "$mntdir/$filename" "$outloc" || return $?
     fi
     [ -f "$outloc" ] || return 253
-    echo "$outloc"
+    if [ -z "$2" ]; then echo "$outloc" ; fi
 }
 command -v nfs_to_var >/dev/null && add_url_handler nfs_fetch_url nfs nfs4
-- 
1.7.7.6
