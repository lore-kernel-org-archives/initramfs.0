From: initramfs mailing list <initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Subject: [PATCH 04/50] Modify root cmdline parsing to use a case statement.
Date: Mon, 16 Feb 2009 14:05:55 -0500
Message-ID: <200902161905.n1GJ5t4h027222@hera.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

Gitweb:     http://git.kernel.org/?p=linux/kernel/git/davej/dracut.git;a=commit;h=f9a0b9f8683acf3b35f45f1fdf472ed6409fa004
Commit:     f9a0b9f8683acf3b35f45f1fdf472ed6409fa004
Parent:     9f99d479b389392a91dd912ce253b933e6881de5
Author:     Victor Lowther <victor.lowther-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
AuthorDate: Fri Feb 13 04:41:40 2009 -0800
Committer:  Dave Jones <davej-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
CommitDate: Mon Feb 16 13:56:40 2009 -0500

    [PATCH 04/50] Modify root cmdline parsing to use a case statement.
    
    This code takes less space and is easier to read at a glance.
---
 init |   21 +++++++++------------
 1 files changed, 9 insertions(+), 12 deletions(-)

diff --git a/init b/init
index 7b2a985..78f962e 100755
--- a/init
+++ b/init
@@ -59,19 +59,16 @@ NEWROOT="/sysroot"
 # it'd be nice if we had a udev rule that just did all of the bits for
 # figuring out what the specified root is and linking it /dev/root
 root=$(getarg 'root=*'); root=${root#root=}
-
 echo -n "Going to mount rootfs ($root)"
-if [ -z "$root" ]; then 
-  echo "Warning: no root specified"
-  root="/dev/sda1"
-elif [ "${root#LABEL=}" != $root ]; then
-  # FIXME: may need to do more escaping here
-  l=${root#LABEL=}
-  label=${l//\//\\x2f}
-  root="/dev/disk/by-label/${label}"
-elif [ "${root#UUID=}" != $root ]; then
-  root="/dev/disk/by-uuid/${root#UUID=}"
-fi
+case $root in
+    LABEL=*) root=${root#LABEL=}
+             root=${root//\//\\x2f}
+	     root="/dev/disk/by-label/${root}" ;;
+    UUID=*) root="/dev/disk/by-uuid/${root#UUID=}" ;;
+    '') echo "Warning: no root specified"
+	root="/dev/sda1" ;;
+esac
+
 # should we have a timeout?
 tries=0
 while [ ! -e $root ]; do
--
To unsubscribe from this list: send the line "unsubscribe initramfs" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
