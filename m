From: Koen Kooi <koen-QLwJDigV5abLmq1fohREcCpxlwaOVQ5f@public.gmane.org>
Subject: [PATCH] Use builtin xz/lzma option to use all cores for multihreaded compression
Date: Fri, 10 Jan 2014 21:41:43 +0100
Message-ID: <1389386503-79006-1-git-send-email-koen@dominion.thruhere.net>
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: Koen Kooi <koen-QLwJDigV5abLmq1fohREcCpxlwaOVQ5f@public.gmane.org>

This removes the dependency on 'getconf' as well, which is not installed by default on my embedded systems.

Signed-off-by: Koen Kooi <koen-QLwJDigV5abLmq1fohREcCpxlwaOVQ5f@public.gmane.org>
---
 dracut.sh | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/dracut.sh b/dracut.sh
index 11dcd0e..2e6ea67 100755
--- a/dracut.sh
+++ b/dracut.sh
@@ -697,14 +697,12 @@ stdloglvl=$((stdloglvl + verbosity_mod_l))
 # eliminate IFS hackery when messing with fw_dir
 fw_dir=${fw_dir//:/ }
 
-cpu_count=$(getconf _NPROCESSORS_ONLN)
-
 # handle compression options.
 [[ $compress ]] || compress="gzip"
 case $compress in
     bzip2) compress="bzip2 -9";;
-    lzma)  compress="lzma -9 ${cpu_count:+-T$cpu_count}";;
-    xz)    compress="xz --check=crc32 --lzma2=dict=1MiB ${cpu_count:+-T$cpu_count}";;
+    lzma)  compress="lzma -9 -T0";;
+    xz)    compress="xz --check=crc32 --lzma2=dict=1MiB -T0";;
     gzip)  compress="gzip -9"; command -v pigz > /dev/null 2>&1 && compress="pigz -9";;
     lzo)   compress="lzop -9";;
     lz4)   compress="lz4 -9";;
-- 
1.8.0
