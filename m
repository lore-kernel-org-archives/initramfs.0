From: Victor Lowther <victor.lowther-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: [PATCH 1/4] Just look for cryptroot instead of /sbin/cryptroot
Date: Wed,  2 Jun 2010 07:07:55 -0500 (CDT)
Message-ID: <4b22ffbe9ef3f55ac4fad54bd58f9cf9fc345b22.1275480426.git.victor.lowther@gmail.com>
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

We know what the path is and what it contains in the initrd, and
not everyone puts cryptroot in /sbin
---
 modules.d/90crypt/cryptroot-ask.sh |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/modules.d/90crypt/cryptroot-ask.sh b/modules.d/90crypt/cryptroot-ask.sh
index 13487c8..2f39667 100755
--- a/modules.d/90crypt/cryptroot-ask.sh
+++ b/modules.d/90crypt/cryptroot-ask.sh
@@ -68,7 +68,7 @@ if [ $ask -gt 0 ]; then
     # flock against other interactive activities
     { flock -s 9; 
 	echo -n "$device ($luksname) is password protected"
-	/sbin/cryptsetup luksOpen -T1 $1 $luksname 
+	cryptsetup luksOpen -T1 $1 $luksname 
     } 9>/.console.lock
 fi
 
-- 
1.7.1
