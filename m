From: Jan Synacek <jsynacek-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: [PATCH 3/3] doc: fix formatting
Date: Wed, 25 Feb 2015 13:16:46 +0100
Message-ID: <1424866606-12545-4-git-send-email-jsynacek@redhat.com>
References: <1424866606-12545-1-git-send-email-jsynacek@redhat.com>
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1424866606-12545-1-git-send-email-jsynacek-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: harald-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org, jsynacek-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org

---
 dracut.8.asc | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/dracut.8.asc b/dracut.8.asc
index 9aecbfb..9bc166a 100644
--- a/dracut.8.asc
+++ b/dracut.8.asc
@@ -462,7 +462,7 @@ will not be able to boot.
     Regenerate all initramfs images at the default location with the kernel
     versions found on the system. Additional parameters are passed through.
 
-**--loginstall _<DIR>_::
+**--loginstall _<DIR>_**::
     Log all files installed from the host to _<DIR>_.
 
 FILES
-- 
2.1.0
