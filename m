From: Thomas Renninger <trenn-l3A5Bk7waGM@public.gmane.org>
Subject: [PATCH 25/33] 99base: warn on invalid command for initqueue
Date: Thu, 20 Nov 2014 15:57:00 +0100
Message-ID: <1416495428-36978-26-git-send-email-trenn@suse.de>
References: <1416495428-36978-1-git-send-email-trenn@suse.de>
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1416495428-36978-1-git-send-email-trenn-l3A5Bk7waGM@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: harald-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org
Cc: hare-l3A5Bk7waGM@public.gmane.org, trenn-l3A5Bk7waGM@public.gmane.org, initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

From: Hannes Reinecke <hare-l3A5Bk7waGM@public.gmane.org>

When 'initqueue' is called with an invalid command it'll generate
invalid job scripts. This will lead to confusing error messages
later on.
So abort in these cases and print out a warning.

Signed-off-by: Hannes Reinecke <hare-l3A5Bk7waGM@public.gmane.org>
Signed-off-by: Thomas Renninger <trenn-l3A5Bk7waGM@public.gmane.org>
---
 modules.d/99base/initqueue.sh | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/modules.d/99base/initqueue.sh b/modules.d/99base/initqueue.sh
index 4a07da3..193cc5c 100755
--- a/modules.d/99base/initqueue.sh
+++ b/modules.d/99base/initqueue.sh
@@ -42,6 +42,10 @@ exe=$1
 shift
 
 [ -x "$exe" ] || exe=$(command -v $exe)
+if [ -z "$exe" ] ; then
+    echo "Invalid command"
+    exit 1
+fi
 
 {
     [ -n "$onetime" ] && echo '[ -e "$job" ] && rm -f -- "$job"'
-- 
1.8.5.2
