From: initramfs mailing list <initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Subject: [PATCH 09/50] Compact option processing.
Date: Mon, 16 Feb 2009 14:06:04 -0500
Message-ID: <200902161906.n1GJ6428027588@hera.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

Gitweb:     http://git.kernel.org/?p=linux/kernel/git/davej/dracut.git;a=commit;h=b368a5f3bb58a795210f4caf3ad43a2757e3d651
Commit:     b368a5f3bb58a795210f4caf3ad43a2757e3d651
Parent:     70c26b7fce5f1cddbd82863c371caaf20b299706
Author:     Victor Lowther <victor.lowther-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
AuthorDate: Fri Feb 13 04:41:52 2009 -0800
Committer:  Dave Jones <davej-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
CommitDate: Mon Feb 16 13:56:40 2009 -0500

    [PATCH 09/50] Compact option processing.
    
    Most of the options are one-liners, and the shift can be factored out of
    the case expression entirely.
---
 dracut |   31 +++++++++----------------------
 1 files changed, 9 insertions(+), 22 deletions(-)

diff --git a/dracut b/dracut
index 0fe0282..82cf9e5 100755
--- a/dracut
+++ b/dracut
@@ -10,30 +10,17 @@
 
 [ -f /etc/dracut.conf ] && . /etc/dracut.conf
 
-while [ $# -gt 0 ]; do
+while (($# > 0)); do
     case $1 in
-	-f|--force)
-	    force=yes
-	    shift
-	    ;;
-	-h|--help)
-	    echo "Usage: $0 [-f] <initramfs> <kernel-version>"
-	    exit 1
-	    ;;
-	-v|--verbose)
-	    set -x
-	    shift
-	    ;;
-	-l|--local)
-	    allowlocal="yes"
-	    shift
-	    ;;
-	--allow-missing)
-	    shift
-	    ;;
-	*)
-	    break
+	-f|--force) force=yes;;
+	-h|--help) echo "Usage: $0 [-f] <initramfs> <kernel-version>"
+	    exit 1 ;;
+	-v|--verbose) set -x;;
+	-l|--local) allowlocal="yes" ;;
+	--allow-missing) : ;;
+	*) break ;;
     esac
+    shift
 done
 
 if [ -n "$2" ]; then
--
To unsubscribe from this list: send the line "unsubscribe initramfs" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
