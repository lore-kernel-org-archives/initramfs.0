From: Amerigo Wang <amwang-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: [Patch] lsinitrd: display the size of initrd
Date: Mon,  1 Aug 2011 14:55:15 +0800
Message-ID: <1312181715-27796-1-git-send-email-amwang@redhat.com>
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: harald-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org, Amerigo Wang <amwang-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>

It is useful to display the size of initrd in human-friendly form.

Signed-off-by: Amerigo Wang <amwang-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>

---
diff --git a/lsinitrd b/lsinitrd
index 3b9cc85..7da9f61 100755
--- a/lsinitrd
+++ b/lsinitrd
@@ -41,7 +41,7 @@ if [[ $# -eq 2 ]]; then
     exit $?
 fi
 
-echo "$image:"
+echo "$image: $(du -h $image | awk '{print $1}')"
 echo "========================================================================"
 $CAT "$image" | cpio --extract --verbose --quiet --to-stdout 'lib/dracut/dracut-*' 2>/dev/null
 echo "========================================================================"
