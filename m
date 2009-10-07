From: Victor Lowther <victor.lowther-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: [PATCH 1/3] We don't need to pass the full path to cryptroot
Date: Wed,  7 Oct 2009 10:48:25 -0500 (CDT)
Message-ID: <a989fe01e19bd214cae75b705ac0c5e8aefb71d4.1254930149.git.victor.lowther@gmail.com>
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

After all, we know what $PATH is.

---
 modules.d/90crypt/cryptroot-ask.sh |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/modules.d/90crypt/cryptroot-ask.sh b/modules.d/90crypt/cryptroot-ask.sh
index 7872d64..0eadeeb 100755
--- a/modules.d/90crypt/cryptroot-ask.sh
+++ b/modules.d/90crypt/cryptroot-ask.sh
@@ -28,7 +28,7 @@ if [ $ask -gt 0 ]; then
     # flock against other interactive activities
     { flock -s 9; 
 	echo -n "$1 is password protected " 
-	/sbin/cryptsetup luksOpen -T1 $1 $2 
+	cryptsetup luksOpen -T1 $1 $2 
     } 9>/.console.lock
 fi
 
-- 
1.6.4.4

--
To unsubscribe from this list: send the line "unsubscribe initramfs" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
