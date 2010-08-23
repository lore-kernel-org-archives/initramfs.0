From: Andrey Borzenkov <arvidjaar-JGs/UdohzUI@public.gmane.org>
Subject: [PATCH] mkinitrd-dracut.sh: fix stray "fi"
Date: Mon, 23 Aug 2010 21:56:24 +0400
Message-ID: <20100823175624.11190.66215.stgit@cooker>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org



Signed-off-by: Andrey Borzenkov <arvidjaar-JGs/UdohzUI@public.gmane.org>

---

 mkinitrd-dracut.sh |    1 -
 1 files changed, 0 insertions(+), 1 deletions(-)

diff --git a/mkinitrd-dracut.sh b/mkinitrd-dracut.sh
index 15b39a6..320a9fe 100644
--- a/mkinitrd-dracut.sh
+++ b/mkinitrd-dracut.sh
@@ -92,7 +92,6 @@ done
 
 [[ $target && $kernel ]] || usage
 [[ $img_vers ]] && target="$target-$kernel"
-fi
 
 if [[ $basicmodules ]]; then
 	dracut $dracut_args --add-drivers "$basicmodules" "$target" "$kernel"
