From: Will Woods <wwoods-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: [PATCH] url-lib: fix fetch_url return value for dotfiles
Date: Thu, 16 Feb 2012 18:54:49 -0500
Message-ID: <1329436489-29509-1-git-send-email-wwoods@redhat.com>
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

If you do "fetch_url $url/.somefile", fetch_url would return failure,
because "$outdir/*" wouldn't match the file.

Use ls -A (which busybox ls supports) to actually find possible dotfiles
in the created output dir.

Signed-off-by: Will Woods <wwoods-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
---
 modules.d/45url-lib/url-lib.sh |    7 ++-----
 1 files changed, 2 insertions(+), 5 deletions(-)

diff --git a/modules.d/45url-lib/url-lib.sh b/modules.d/45url-lib/url-lib.sh
index ddebdc9..7b669f4 100755
--- a/modules.d/45url-lib/url-lib.sh
+++ b/modules.d/45url-lib/url-lib.sh
@@ -60,11 +60,8 @@ curl_fetch_url() {
         curl $curl_args --output "$outloc" "$url" || return $?
     else
         local outdir="$(mkuniqdir /tmp curl_fetch_url)"
-        local cwd="$(pwd)"
-        cd "$outdir"
-        curl $curl_args --remote-name "$url" || return $?
-        cd "$cwd"
-        outloc="$(echo $outdir/*)"
+        ( cd "$outdir"; curl $curl_args --remote-name "$url" || return $? )
+        outloc="$outdir/$(ls -A $outdir)"
     fi
     [ -f "$outloc" ] || return 253
     echo "$outloc"
-- 
1.7.7.6
