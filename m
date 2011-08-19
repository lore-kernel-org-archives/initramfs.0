From: John Reiser <jreiser-Po6cBsTGB2ZWk0Htik3J/w@public.gmane.org>
Subject: build initramfs: prelink --undo /sbin/*
Date: Thu, 18 Aug 2011 20:55:35 -0700
Message-ID: <4E4DDEB7.3050602@bitwagon.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

Fix a typo (omitting the 's' in "sbin") which caused
"prelink --undo" twice on      /bin/*,  and
"prelink --undo" omitted for  /sbin/*.

diff --git a/dracut b/dracut
index cf27b23..601fb6c 100755
--- a/dracut
+++ b/dracut
@@ -642,7 +642,7 @@ type hardlink &>/dev/null && {
  if strstr "$modules_loaded" " fips " && command -v prelink >/dev/null; then
     for i in $initdir/bin/* \
-       $initdir/bin/* \
+       $initdir/sbin/* \
        $initdir/usr/bin/* \
        $initdir/usr/sbin/*; do
        [ -x $i ] && prelink -u $i &>/dev/null

-- 
