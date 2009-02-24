From: initramfs mailing list <initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Subject: Make cryptroot handling act as a real producer/consumer.
Date: Tue, 24 Feb 2009 05:00:14 GMT
Message-ID: <200902240500.n1O50EfO011259@hera.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

Gitweb:     http://git.kernel.org/?p=linux/kernel/git/davej/dracut.git;a=commit;h=5ee69f0b54d301c74553fcc0ebc360110a3d1205
Commit:     5ee69f0b54d301c74553fcc0ebc360110a3d1205
Parent:     9689f4c8cefc72f7d95d22d557765da9acb1f883
Author:     Victor Lowther <victor.lowther-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
AuthorDate: Sat Feb 21 08:24:39 2009 -0800
Committer:  Dave Jones <davej-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
CommitDate: Mon Feb 23 13:22:01 2009 -0500

    Make cryptroot handling act as a real producer/consumer.
    
    This should handle the case of having more than one encrypted
    block device on the system as best we can right now.
---
 hooks/cryptroot.sh    |   11 +++++++----
 rules.d/63-luks.rules |    2 +-
 2 files changed, 8 insertions(+), 5 deletions(-)

diff --git a/hooks/cryptroot.sh b/hooks/cryptroot.sh
index 0664f24..739f5d3 100755
--- a/hooks/cryptroot.sh
+++ b/hooks/cryptroot.sh
@@ -1,7 +1,10 @@
 #!/bin/sh
-[ -f /cryptroot ] && { 
-    echo "Encrypted root detected."
-    read cryptopts </cryptroot
-    /sbin/cryptsetup luksOpen $cryptopts || emergency_shell
+[ -s /cryptroot ] && { 
+    udevadm control --stop_exec_queue
+    while read cryptopts; do
+	/sbin/cryptsetup luksOpen $cryptopts
+    done </cryptroot
+    >/cryptroot
+    udevadm control --start_exec_queue
     udevadm settle --timeout=30
 }
diff --git a/rules.d/63-luks.rules b/rules.d/63-luks.rules
index 4d6a379..802ea06 100644
--- a/rules.d/63-luks.rules
+++ b/rules.d/63-luks.rules
@@ -8,6 +8,6 @@ SUBSYSTEM!="block", GOTO="luks_end"
 ACTION!="add|change", GOTO="luks_end"
 
 KERNEL!="sr*", IMPORT{program}="vol_id --export $tempnode"
-ENV{ID_FS_TYPE}=="crypto_LUKS", RUN+="/bin/sh -c 'echo $env{DEVNAME} luks-$env{ID_FS_UUID} >/cryptroot'"
+ENV{ID_FS_TYPE}=="crypto_LUKS", RUN+="/bin/sh -c 'echo $env{DEVNAME} luks-$env{ID_FS_UUID} >>/cryptroot'"
 
 LABEL="luks_end"
--
To unsubscribe from this list: send the line "unsubscribe initramfs" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
