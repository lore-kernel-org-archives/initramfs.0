From: Stig Telfer <stelfer-WVYJKLFxKCc@public.gmane.org>
Subject: [PATCH] url-lib: extend to enable TFTP support
Date: Mon, 16 Dec 2013 15:17:47 +0000
Message-ID: <E86DFAF410366A40AD1683994061D9D605DE54@CFWEX01.americas.cray.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Language: en-US
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
To: "initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>

Libcurl has wider capabilities than those assigned to it by Dracut.  In this patch to url-lib I've added registration for TFTP URLs, which I've found to be useful.

Enjoy,
Stig Telfer


diff --git a/modules.d/45url-lib/url-lib.sh b/modules.d/45url-lib/url-lib.sh
index 12df9b4..c9d143a 100755
--- a/modules.d/45url-lib/url-lib.sh
+++ b/modules.d/45url-lib/url-lib.sh
@@ -76,7 +76,7 @@ curl_fetch_url() {
     fi
     if [ -z "$2" ]; then echo "$outloc" ; fi
 }
-add_url_handler curl_fetch_url http https ftp
+add_url_handler curl_fetch_url http https ftp tftp

 set_http_header() {
     echo "header = \"$1: $2\"" >> $CURL_HOME/.curlrc
