From: initramfs mailing list <initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Subject: [PATCH 05/50] Rewrite the mount loop using bash-specific features.
Date: Mon, 16 Feb 2009 14:05:57 -0500
Message-ID: <200902161905.n1GJ5vnK027249@hera.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

Gitweb:     http://git.kernel.org/?p=linux/kernel/git/davej/dracut.git;a=commit;h=e0bb3c3613a7b706984f12829892365fa42a404d
Commit:     e0bb3c3613a7b706984f12829892365fa42a404d
Parent:     f9a0b9f8683acf3b35f45f1fdf472ed6409fa004
Author:     Victor Lowther <victor.lowther-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
AuthorDate: Fri Feb 13 04:41:42 2009 -0800
Committer:  Dave Jones <davej-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
CommitDate: Mon Feb 16 13:56:40 2009 -0500

    [PATCH 05/50] Rewrite the mount loop using bash-specific features.
    
    This makes the loop slightly more compact and easier to read.
---
 init |    7 ++-----
 1 files changed, 2 insertions(+), 5 deletions(-)

diff --git a/init b/init
index 78f962e..2ebf1b0 100755
--- a/init
+++ b/init
@@ -71,13 +71,10 @@ esac
 
 # should we have a timeout?
 tries=0
-while [ ! -e $root ]; do
+until [[ -e $root ]]; do
   echo -n "."
   sleep 1
-  tries=$(($tries + 1))
-  if [ $tries -gt 30 ]; then
-      emergency_shell
-  fi
+  ((tries++ > 30)) && emergency_shell
 done
 echo -e "\n\nMounting rootfs after $tries seconds"
 ln -s "$root" /dev/root    
--
To unsubscribe from this list: send the line "unsubscribe initramfs" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
