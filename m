From: initramfs mailing list <initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Subject: cryptsetup does not like running in a while read loop.
Date: Wed, 25 Feb 2009 05:00:01 GMT
Message-ID: <200902250500.n1P501nk006385@hera.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

Gitweb:     http://git.kernel.org/?p=linux/kernel/git/davej/dracut.git;a=commit;h=19e9dd9303085d3186d86999805d1a862c61aaeb
Commit:     19e9dd9303085d3186d86999805d1a862c61aaeb
Parent:     5ee69f0b54d301c74553fcc0ebc360110a3d1205
Author:     Victor Lowther <victor.lowther-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
AuthorDate: Sun Feb 22 00:22:36 2009 -0600
Committer:  Dave Jones <davej-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
CommitDate: Tue Feb 24 14:53:42 2009 -0500

    cryptsetup does not like running in a while read loop.
    
    Add some additional manglage to ensure that stdin/stdout is always pointing
    the right thing.  A more elegant way of doing this would be much appreciated
---
 hooks/cryptroot.sh |    4 +++-
 1 files changed, 3 insertions(+), 1 deletions(-)

diff --git a/hooks/cryptroot.sh b/hooks/cryptroot.sh
index 739f5d3..1bcc68f 100755
--- a/hooks/cryptroot.sh
+++ b/hooks/cryptroot.sh
@@ -2,7 +2,9 @@
 [ -s /cryptroot ] && { 
     udevadm control --stop_exec_queue
     while read cryptopts; do
-	/sbin/cryptsetup luksOpen $cryptopts
+       (   exec >/dev/console 2>&1 </dev/console
+           /sbin/cryptsetup luksOpen $cryptopts || emergency_shell
+       )
     done </cryptroot
     >/cryptroot
     udevadm control --start_exec_queue
--
To unsubscribe from this list: send the line "unsubscribe initramfs" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
