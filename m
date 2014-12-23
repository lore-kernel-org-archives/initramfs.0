From: Lubomir Rintel <lkundrak-NGH9Lh4a5iE@public.gmane.org>
Subject: [PATCH] dracut-functions.sh: avoid tokenizing ldconfig output with 'read'
Date: Tue, 23 Dec 2014 22:03:10 +0100
Message-ID: <1419368590-2052-1-git-send-email-lkundrak@v3.sk>
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: Lubomir Rintel <lkundrak-NGH9Lh4a5iE@public.gmane.org>

The space does not separate the elements reliably, spaces can be
embedded in parenthesized expressions too:

  libgmpxx.so.4 (libc6, hwcap: 0x0000000004000000) => /lib/sse2/libgmpxx.so.4
  libgmp.so.10 (libc6, hwcap: 0x0000000004000000) => /lib/sse2/libgmp.so.10

This results in dracut creating '0x0000000004000000' and '=>'
directories in the initramfs image.
---
 dracut-functions.sh | 12 +-----------
 1 file changed, 1 insertion(+), 11 deletions(-)

diff --git a/dracut-functions.sh b/dracut-functions.sh
index 410960d..37ddca2 100755
--- a/dracut-functions.sh
+++ b/dracut-functions.sh
@@ -104,17 +104,7 @@ fi
 
 ldconfig_paths()
 {
-    local a i
-    declare -A a
-    for i in $(
-        ldconfig -pN 2>/dev/null | grep -F '=>' | grep -E -v '/(lib|lib64|usr/lib|usr/lib64)/[^/]*$' | while read a b c d; do
-            d=${d%/*}
-            printf "%s\n" "$d";
-        done
-    ); do
-        a["$i"]=1;
-    done;
-    printf "%s\n" ${!a[@]}
+    ldconfig -pN 2>/dev/null | grep -E -v '/(lib|lib64|usr/lib|usr/lib64)/[^/]*$' | sed -n 's,.* => \(.*\)/.*,\1,p' | sort | uniq
 }
 
 # Detect lib paths
-- 
2.1.0
