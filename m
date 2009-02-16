From: initramfs mailing list <initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Subject: [PATCH 03/50] Use getarg to get the root kernel commandline parameter.
Date: Mon, 16 Feb 2009 14:05:53 -0500
Message-ID: <200902161905.n1GJ5rv2027194@hera.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

Gitweb:     http://git.kernel.org/?p=linux/kernel/git/davej/dracut.git;a=commit;h=9f99d479b389392a91dd912ce253b933e6881de5
Commit:     9f99d479b389392a91dd912ce253b933e6881de5
Parent:     047891955e9039ea4242c941d6c4bc617528226a
Author:     Victor Lowther <victor.lowther-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
AuthorDate: Fri Feb 13 04:41:38 2009 -0800
Committer:  Dave Jones <davej-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
CommitDate: Mon Feb 16 13:56:40 2009 -0500

    [PATCH 03/50] Use getarg to get the root kernel commandline parameter.
---
 init |    9 ++-------
 1 files changed, 2 insertions(+), 7 deletions(-)

diff --git a/init b/init
index b5b0b1b..7b2a985 100755
--- a/init
+++ b/init
@@ -58,13 +58,8 @@ NEWROOT="/sysroot"
 # FIXME: there's got to be a better way ...
 # it'd be nice if we had a udev rule that just did all of the bits for
 # figuring out what the specified root is and linking it /dev/root
-for o in `cat /proc/cmdline` ; do
-  case $o in 
-  root=*)
-    root=${o#root=}
-    ;;
-  esac
-done
+root=$(getarg 'root=*'); root=${root#root=}
+
 echo -n "Going to mount rootfs ($root)"
 if [ -z "$root" ]; then 
   echo "Warning: no root specified"
--
To unsubscribe from this list: send the line "unsubscribe initramfs" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
