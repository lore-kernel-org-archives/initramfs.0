From: initramfs mailing list <initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Subject: We now support the noresume kernel parameter.
Date: Tue, 24 Feb 2009 05:00:08 GMT
Message-ID: <200902240500.n1O508D8010935@hera.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

Gitweb:     http://git.kernel.org/?p=linux/kernel/git/davej/dracut.git;a=commit;h=c9ac929ddff9aec5c9951815774a7bcb5d120df9
Commit:     c9ac929ddff9aec5c9951815774a7bcb5d120df9
Parent:     27994f9e28546e0bcf352b5217c54ff287183789
Author:     Victor Lowther <victor.lowther-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
AuthorDate: Sat Feb 21 08:24:25 2009 -0800
Committer:  Dave Jones <davej-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
CommitDate: Mon Feb 23 13:22:01 2009 -0500

    We now support the noresume kernel parameter.
---
 hooks/resume.sh |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/hooks/resume.sh b/hooks/resume.sh
index 4f1d6c3..619d634 100755
--- a/hooks/resume.sh
+++ b/hooks/resume.sh
@@ -1,5 +1,5 @@
 #!/bin/sh
-resume=$(getarg resume) && {
+resume=$(getarg resume) && [ "$(getarg noresume)" = "" ] && {
     resume=${resume#resume=}
     [ -b "$resume" ] && {
         # parsing the output of ls is Bad, but until there is a better way...
--
To unsubscribe from this list: send the line "unsubscribe initramfs" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
