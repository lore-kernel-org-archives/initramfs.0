From: Alexander Tsoy <alexander-EP/B3+myoZc@public.gmane.org>
Subject: [PATCHv2] Add legacy flag (-l) to lz4 and update magic number
Date: Wed, 26 Feb 2014 15:50:17 +0400
Message-ID: <E1WIdCN-0000Jz-Gd@secretive.ru>
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=tsoy.me; s=secretive;
	h=Message-Id:To:Subject:Date:From; bh=e7YMv+JWcvPh4qyU1ePyEhHSbQQEXjpZtvwHybOtz6o=;
	b=X+Dqf7n9Hpw6jkfT2oLgtYG0KSP1ouaLQM8AMPYIeH+HyYNzcJ+XNbwwqmCMprF9FpmxsDOHXPsNC6Dy6AUepZMGkrSrc87y+gFKNBP1XCCUSCePIDktN1ns8FcbGTIt75efpcrMxJChKVy9+iwXutSSF35rUZMpGmkUKK6/3OM=;
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

Linux kernel does not support the new default lz4 format.

https://bugs.gentoo.org/show_bug.cgi?id=502102
---
 dracut.sh   | 2 +-
 lsinitrd.sh | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/dracut.sh b/dracut.sh
index 5267af5..49077fd 100755
--- a/dracut.sh
+++ b/dracut.sh
@@ -782,7 +782,7 @@ case $compress in
     xz)    compress="xz --check=crc32 --lzma2=dict=1MiB -T0";;
     gzip)  compress="gzip -9"; command -v pigz > /dev/null 2>&1 && compress="pigz -9";;
     lzo)   compress="lzop -9";;
-    lz4)   compress="lz4 -9";;
+    lz4)   compress="lz4 -l -9";;
 esac
 if [[ $_no_compress_l = "cat" ]]; then
     compress="cat"
diff --git a/lsinitrd.sh b/lsinitrd.sh
index 2c58f84..8dc9032 100755
--- a/lsinitrd.sh
+++ b/lsinitrd.sh
@@ -172,7 +172,7 @@ case $bin in
     $'\x71\xc7'*|070701)
         CAT="cat --"
         ;;
-    $'\x04\x22'*)
+    $'\x02\x21'*)
         CAT="lz4 -d -c";;
     *)
         CAT="xzcat --";
-- 
1.8.3.2
