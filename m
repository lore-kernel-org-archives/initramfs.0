From: initramfs mailing list <initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Subject: [PATCH 20/50] set_verbose is not used anywhere.  Buh-bye.
Date: Mon, 16 Feb 2009 14:06:25 -0500
Message-ID: <200902161906.n1GJ6PZd028041@hera.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

Gitweb:     http://git.kernel.org/?p=linux/kernel/git/davej/dracut.git;a=commit;h=375a5b4084db4e1d51746fea8dc8bb2b731e5b67
Commit:     375a5b4084db4e1d51746fea8dc8bb2b731e5b67
Parent:     6b24de99d9b9a78496d4aca9e5d55de45bcd8341
Author:     Victor Lowther <victor.lowther-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
AuthorDate: Fri Feb 13 04:42:18 2009 -0800
Committer:  Dave Jones <davej-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
CommitDate: Mon Feb 16 13:56:41 2009 -0500

    [PATCH 20/50] set_verbose is not used anywhere.  Buh-bye.
---
 dracut-functions |    4 ----
 1 files changed, 0 insertions(+), 4 deletions(-)

diff --git a/dracut-functions b/dracut-functions
index 7f9dfcd..26254a4 100755
--- a/dracut-functions
+++ b/dracut-functions
@@ -24,10 +24,6 @@
 #
 #
 
-set_verbose() {
-    foo=""
-}
-
 IF_RTLD=""
 IF_dynamic=""
 get_dso_deps() {
--
To unsubscribe from this list: send the line "unsubscribe initramfs" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
