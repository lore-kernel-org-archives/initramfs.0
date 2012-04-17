From: =?UTF-8?q?Amadeusz=20=C5=BBo=C5=82nowski?= <aidecoe-2qtfh70TtYba5EbDDlwbIw@public.gmane.org>
Subject: [PATCH] lsinitrd: support symlinks
Date: Tue, 17 Apr 2012 11:31:27 +0200
Message-ID: <1334655087-16937-1-git-send-email-aidecoe@aidecoe.name>
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: Nikoli <nikoli-N9AOi2cAC9ZBDgjK7y7TUQ@public.gmane.org>

From: Nikoli <nikoli-N9AOi2cAC9ZBDgjK7y7TUQ@public.gmane.org>

---
 lsinitrd.sh |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/lsinitrd.sh b/lsinitrd.sh
index 1eaa37d..e6767dc 100755
--- a/lsinitrd.sh
+++ b/lsinitrd.sh
@@ -34,7 +34,7 @@ image="${1:-/boot/initramfs-$(uname -r).img}"
 [[ -f "$image" ]]    || { echo "$image does not exist" ; exit 1 ; }
 
 CAT=zcat
-FILE_T=$(file "$image")
+FILE_T=$(file --dereference "$image")
 
 if echo "test"|xz|xz -dc --single-stream >/dev/null 2>&1; then
     XZ_SINGLE_STREAM="--single-stream"
-- 
1.7.3.4
