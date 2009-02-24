From: initramfs mailing list <initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Subject: tiny fixup to getarg to make handling more arguments slightly easier
Date: Tue, 24 Feb 2009 05:00:06 GMT
Message-ID: <200902240500.n1O506E0010779@hera.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

Gitweb:     http://git.kernel.org/?p=linux/kernel/git/davej/dracut.git;a=commit;h=27994f9e28546e0bcf352b5217c54ff287183789
Commit:     27994f9e28546e0bcf352b5217c54ff287183789
Parent:     9cead591ad8fa7de856d4dc3777bb7c155a6d3b8
Author:     Victor Lowther <victor.lowther-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
AuthorDate: Sat Feb 21 08:24:20 2009 -0800
Committer:  Dave Jones <davej-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
CommitDate: Mon Feb 23 13:22:01 2009 -0500

    tiny fixup to getarg to make handling more arguments slightly easier
    
    This patch series adds support for some common mount arguments that have to be
    handled in the initramfs.
    
    It is also available at
    http://git.fnordovax.org/dracut/log/?h=handle-more-parameters
---
 init |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/init b/init
index 358ef02..ee1123c 100755
--- a/init
+++ b/init
@@ -16,7 +16,7 @@ emergency_shell()
 getarg() {
     local o line
     for o in $CMDLINE; do
-	[ "${o%%=*}" = "$1" ] && { echo $o; break; }
+	[ "${o%%=*}" = "$1" ] && { echo $o; return 0; }
     done
     return 1
 }
--
To unsubscribe from this list: send the line "unsubscribe initramfs" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
