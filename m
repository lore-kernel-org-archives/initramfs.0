From: "Brian C. Lane" <bcl-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: [PATCH] Add rd.noverifyssl argument (#852229)
Date: Mon,  8 Oct 2012 15:00:54 -0700
Message-ID: <1349733654-24458-1-git-send-email-bcl@redhat.com>
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

From: "Brian C. Lane" <bcl-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>

This adds --insecure to the curl args so that self-signed certificates
will be accepted.
---
 modules.d/45url-lib/url-lib.sh | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/modules.d/45url-lib/url-lib.sh b/modules.d/45url-lib/url-lib.sh
index a8069ef..034a7cd 100755
--- a/modules.d/45url-lib/url-lib.sh
+++ b/modules.d/45url-lib/url-lib.sh
@@ -54,7 +54,8 @@ add_url_handler() {
 
 export CURL_HOME="/run/initramfs/url-lib"
 mkdir -p $CURL_HOME
-curl_args="--location --retry 3 --fail --show-error --insecure"
+curl_args="--location --retry 3 --fail --show-error"
+getargbool 0 rd.noverifyssl && curl_args+=" --insecure"
 
 curl_fetch_url() {
     local url="$1" outloc="$2"
-- 
1.7.11.4
