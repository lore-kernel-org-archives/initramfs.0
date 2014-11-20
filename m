From: Thomas Renninger <trenn-l3A5Bk7waGM@public.gmane.org>
Subject: [PATCH 29/33] Check for logfile (--logfile option) and create it if necessary
Date: Thu, 20 Nov 2014 15:57:04 +0100
Message-ID: <1416495428-36978-30-git-send-email-trenn@suse.de>
References: <1416495428-36978-1-git-send-email-trenn@suse.de>
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1416495428-36978-1-git-send-email-trenn-l3A5Bk7waGM@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: harald-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org
Cc: hare-l3A5Bk7waGM@public.gmane.org, trenn-l3A5Bk7waGM@public.gmane.org, initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, jloeser <jloeser-l3A5Bk7waGM@public.gmane.org>

From: jloeser <jloeser-l3A5Bk7waGM@public.gmane.org>

If a logfile is passed to dracut via --logfile option and doesn't
exist, dracut doesn't create it and logs nothing. Instead, dracut
should try to touch the file and print a warning if creating fails.

References: bnc#892191
Signed-off-by: Thomas Renninger <trenn-l3A5Bk7waGM@public.gmane.org>
---
 dracut.sh | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/dracut.sh b/dracut.sh
index 9a19b43..c657649 100755
--- a/dracut.sh
+++ b/dracut.sh
@@ -816,6 +816,16 @@ stdloglvl=$((stdloglvl + verbosity_mod_l))
 # eliminate IFS hackery when messing with fw_dir
 fw_dir=${fw_dir//:/ }
 
+# check for logfile and try to create one if it doesn't exist
+if [[ -n "$logfile" ]];then
+    if [[ ! -f "$logfile" ]];then
+        touch "$logfile"
+        if [ ! $? -eq 0 ] ;then
+            printf "%s\n" "dracut: touch $logfile failed." >&2
+        fi
+    fi
+fi
+
 # handle compression options.
 [[ $compress ]] || compress="gzip"
 case $compress in
-- 
1.8.5.2
