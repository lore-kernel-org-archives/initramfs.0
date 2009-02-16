From: initramfs mailing list <initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Subject: [PATCH 38/50] Missed some non-POSIX substitution in root filesystem label parsing.
Date: Mon, 16 Feb 2009 14:07:00 -0500
Message-ID: <200902161907.n1GJ70Bd028555@hera.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

Gitweb:     http://git.kernel.org/?p=linux/kernel/git/davej/dracut.git;a=commit;h=2a3efd82e55ccd4cbd6e039d5cf70569ae4767f6
Commit:     2a3efd82e55ccd4cbd6e039d5cf70569ae4767f6
Parent:     8c1faa35c4e6d449f4744c12a827e3a87c464696
Author:     Victor Lowther <victor.lowther-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
AuthorDate: Fri Feb 13 04:43:02 2009 -0800
Committer:  Dave Jones <davej-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
CommitDate: Mon Feb 16 13:56:42 2009 -0500

    [PATCH 38/50] Missed some non-POSIX substitution in root filesystem label parsing.
---
 init |    6 +++---
 1 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/init b/init
index 84ae051..4b36e69 100755
--- a/init
+++ b/init
@@ -10,7 +10,7 @@ emergency_shell()
     echo ; echo
     echo "Bug in initramfs /init detected. Dropping to a shell. Good luck!"
     echo
-    sh < /dev/console
+    exec sh -i
 }
 
 getarg() {
@@ -34,7 +34,7 @@ export TERM=linux
 trap "emergency_shell" 0
 # /dev/console comes from the built-in initramfs crud in the kernel
 # someday, we may need to mkdir /dev first here
-exec > /dev/console 2>&1 < /dev/console
+# exec > /dev/console 2>&1 < /dev/console
 
 # mount some important things
 mount -t proc /proc /proc
@@ -66,7 +66,7 @@ NEWROOT="/sysroot"
 root=$(getarg root); root=${root#root=}
 case $root in
     LABEL=*) root=${root#LABEL=}
-             root=${root//\//\\x2f}
+             root="$(echo $root |sed 's,/,\\x2f,g')"
 	     root="/dev/disk/by-label/${root}" ;;
     UUID=*) root="/dev/disk/by-uuid/${root#UUID=}" ;;
     '') echo "Warning: no root specified"
--
To unsubscribe from this list: send the line "unsubscribe initramfs" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
