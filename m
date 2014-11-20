From: Thomas Renninger <trenn-l3A5Bk7waGM@public.gmane.org>
Subject: [PATCH 22/33] Print stored dracut commandline during initramfs build
Date: Thu, 20 Nov 2014 15:56:57 +0100
Message-ID: <1416495428-36978-23-git-send-email-trenn@suse.de>
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

When generating the initramfs we should be printing out the
generated dracut commandline used for booting.
This will simplify debugging.

Signed-off-by: Hannes Reinecke <hare-l3A5Bk7waGM@public.gmane.org>
Signed-off-by: Thomas Renninger <trenn-l3A5Bk7waGM@public.gmane.org>
---
 dracut.sh | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/dracut.sh b/dracut.sh
index 4590f79..9a19b43 100755
--- a/dracut.sh
+++ b/dracut.sh
@@ -1576,6 +1576,16 @@ if ! ( echo $PARMS_TO_STORE > $initdir/lib/dracut/build-parameter.txt ); then
     exit 1
 fi
 
+if [[ $hostonly_cmdline ]] ; then
+    if [ -d $initdir/etc/cmdline.d ];then
+        dinfo "Stored kernel commandline:"
+        for conf in $initdir/etc/cmdline.d/*.conf ; do
+            dinfo "$(< $conf)"
+        done
+    else
+        dinfo "No dracut internal kernel commandline stored in initrd"
+    fi
+fi
 rm -f -- "$outfile"
 dinfo "*** Creating image file ***"
 
-- 
1.8.5.2
