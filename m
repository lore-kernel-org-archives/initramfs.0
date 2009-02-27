From: Seewer Philippe <philippe.seewer-omB+W0Dpw2o@public.gmane.org>
Subject: [PATCH] Create directories for symlinked libraries if needed
Date: Fri, 27 Feb 2009 15:45:53 +0100
Message-ID: <49A7FCA1.7010705@bfh.ch>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"; format="flowed"
To: "<initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>" <initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>

Sometimes symlinks for libraries reside in weird places. Create those 
weird places if necessary.

--
  dracut-functions |    1 +
  1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/dracut-functions b/dracut-functions
index 0fcfe53..cca63e6 100755
--- a/dracut-functions
+++ b/dracut-functions
@@ -45,6 +45,7 @@ inst_library() {
  	reallib="$(readlink -f "$src")"
  	lib=${src##*/}
  	inst_simple "$reallib" "$reallib"
+	mkdir -p ${initdir}${dest%/*}
  	(cd "${initdir}${dest%/*}" && ln -s "$reallib" "$lib")
      else
  	inst_simple "$src" "$dest"
--
To unsubscribe from this list: send the line "unsubscribe initramfs" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
