From: Victor Lowther <victor.lowther-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: [PATCH 01/18] Bashify drivers_dir check
Date: Sun, 16 Aug 2009 16:14:54 -0500 (CDT)
Message-ID: <0b90cfaa9ff10f594018fdcc686fe1b7a3924e4f.1250455879.git.victor.lowther@gmail.com>
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

This patch series includes some code cleanups, makes --hostonly mode a bit more
finegrained w.r.t initramfs creation, and lays some groundwork for integrating 
dracut-gencmdline in with the rest of dracut.

---
 dracut |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/dracut b/dracut
index 6e47077..78cd2ef 100755
--- a/dracut
+++ b/dracut
@@ -136,7 +136,7 @@ esac
 [[ $1 ]] && outfile=$(readlink -f $1) || outfile="/boot/initrd-$kernel.img"
 
 srcmods="/lib/modules/$kernel/"
-[ -n "$drivers_dir" ] && srcmods="$drivers_dir"
+[[ $drivers_dir ]] && srcmods="$drivers_dir"
 export srcmods
 
 if [[ -f $outfile && ! $force ]]; then
-- 
1.6.0.4

--
To unsubscribe from this list: send the line "unsubscribe initramfs" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
