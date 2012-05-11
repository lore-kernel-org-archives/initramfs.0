From: Will Woods <wwoods-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: [PATCH 3/3] url-lib: fix progressbar on s390, again
Date: Fri, 11 May 2012 18:45:08 -0400
Message-ID: <1336776308-15211-3-git-send-email-wwoods@redhat.com>
References: <1336776308-15211-1-git-send-email-wwoods@redhat.com>
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1336776308-15211-1-git-send-email-wwoods-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

It turns out that you can't rely on s390 setting TERM to anything
useful, so we just have to disable progressbar on all s390 systems.
---
 modules.d/45url-lib/url-lib.sh |    6 +++---
 1 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/modules.d/45url-lib/url-lib.sh b/modules.d/45url-lib/url-lib.sh
index 5721294..8a50c6f 100755
--- a/modules.d/45url-lib/url-lib.sh
+++ b/modules.d/45url-lib/url-lib.sh
@@ -56,9 +56,9 @@ export CURL_HOME="/run/initramfs/url-lib"
 mkdir -p $CURL_HOME
 curl_args="--location --retry 3 --fail --show-error"
 
-# technically "dumb" can handle the progress bar, but the only thing I've ever
-# seen using TERM=dumb is s390 CMS, and it's too dumb for --progress-bar
-[ "$TERM" != "dumb" ] && curl_args="$curl_args --progress-bar"
+# s390 x3270 consoles are too dumb for --progress-bar, and they don't seem to
+# set TERM usefully, so we just have to disable it for all s390 systems.
+strstr "$(uname -m)" "s390" || curl_args="$curl_args --progress-bar"
 
 curl_fetch_url() {
     local url="$1" outloc="$2"
-- 
1.7.7.6
