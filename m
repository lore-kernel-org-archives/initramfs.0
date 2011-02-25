From: =?UTF-8?q?Amadeusz=20=C5=BBo=C5=82nowski?= <aidecoe-2qtfh70TtYba5EbDDlwbIw@public.gmane.org>
Subject: [PATCH] dracut-functions: fixed doubled $initdir prefix inst_library()
Date: Fri, 25 Feb 2011 09:59:34 +0100
Message-ID: <1298624374-23980-1-git-send-email-aidecoe@aidecoe.name>
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: =?UTF-8?q?Amadeusz=20=C5=BBo=C5=82nowski?= <aidecoe-2qtfh70TtYba5EbDDlwbIw@public.gmane.org>

Commit 172d85b9c949b321771d63dbd5f06ecf19cf94f0 caused following error:

./dracut-functions: line 307: cd: /tmp/initramfs.mP7cPY/tmp/initramfs.mP7cPY/lib64: No such file or directory

Patch removes beginning $initdir for symlink case.
---
 dracut-functions |    6 ++++--
 1 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/dracut-functions b/dracut-functions
index 1cb43e7..cc16760 100755
--- a/dracut-functions
+++ b/dracut-functions
@@ -302,8 +302,10 @@ inst_library() {
         lib=${src##*/}
         inst_simple "$reallib" "$reallib"
         inst_dir "${dest%/*}"
-        [[ -L ${initdir}${dest%/*} ]] && \
-        dest=$(readlink -f ${initdir}${dest%/*})/
+        if [[ -L ${initdir}${dest%/*} ]]; then
+            dest=$(readlink -f ${initdir}${dest%/*})/
+            dest=${dest#${initdir}}
+        fi
         (cd "${initdir}${dest%/*}" && ln -s "$reallib" "$lib")
     else
         inst_simple "$src" "$dest"
-- 
1.7.4.1
