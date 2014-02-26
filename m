From: Alexander Tsoy <alexander-EP/B3+myoZc@public.gmane.org>
Subject: [PATCH] dracut.sh: add legacy flag (-l) to lz4
Date: Wed, 26 Feb 2014 14:20:54 +0400
Message-ID: <E1WIbkL-0000mN-Ao@secretive.ru>
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=tsoy.me; s=secretive;
	h=Message-Id:To:Subject:Date:From; bh=X9f3l1eQgp1VdtgPfbSZcmmxIARyknYXg0hBK38DsCc=;
	b=IUm18lW6YJZd28nc56sX7lUhZ5UmdVNsrMv18IjGeYSGQOPhFKccYAWX3BC0/o0cVZ5frXLTGVDZDrKpufOkB99AjRh1rA6GwRzSLTsFjfZrPI8f95YirOSkS8+BqwtsJy1zVxBARMQD9Hnu5U+aZH334bVt578ZjnFpOd80NDw=;
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

Linux kernel does not support the new default lz4 format.

https://bugs.gentoo.org/show_bug.cgi?id=502102
---
 dracut.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

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
-- 
1.8.3.2
