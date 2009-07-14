From: Hans de Goede <hdegoede-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: [PATCH 1/3] Fix lvm on top of dmraid
Date: Tue, 14 Jul 2009 22:24:41 +0200
Message-ID: <1247603083-3513-1-git-send-email-hdegoede@redhat.com>
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Discussion of Development and Customization of the Red Hat Linux Installer <anaconda-devel-list-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, initramfs <initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Cc: Harald Hoyer <harald-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, Hans de Goede <hdegoede-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>

The lvm rules were failing to identify PV's on mdraid because
blkid/vol_id has not been run on md raidsets by previous rules.
---
 modules.d/90lvm/64-lvm-vol_id.rules |    1 +
 modules.d/90lvm/64-lvm.rules        |    1 +
 2 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/modules.d/90lvm/64-lvm-vol_id.rules b/modules.d/90lvm/64-lvm-vol_id.rules
index d3a07c1..f5f3a6f 100644
--- a/modules.d/90lvm/64-lvm-vol_id.rules
+++ b/modules.d/90lvm/64-lvm-vol_id.rules
@@ -8,6 +8,7 @@ SUBSYSTEM!="block", GOTO="lvm_end"
 ACTION!="add|change", GOTO="lvm_end"
 
 KERNEL=="dm-*", IMPORT{program}="vol_id --export $tempnode"
+KERNEL=="md*", IMPORT{program}="/sbin/blkid -o udev -p $tempnode"
 
 ENV{ID_FS_TYPE}=="LVM2_member", \
     TEST!="/tmp/.lvm_scan-%k", \
diff --git a/modules.d/90lvm/64-lvm.rules b/modules.d/90lvm/64-lvm.rules
index 3403020..a1c2d1f 100644
--- a/modules.d/90lvm/64-lvm.rules
+++ b/modules.d/90lvm/64-lvm.rules
@@ -8,6 +8,7 @@ SUBSYSTEM!="block", GOTO="lvm_end"
 ACTION!="add|change", GOTO="lvm_end"
 
 KERNEL=="dm-*", IMPORT{program}="/sbin/blkid -o udev -p $tempnode"
+KERNEL=="md*", IMPORT{program}="/sbin/blkid -o udev -p $tempnode"
 
 ENV{ID_FS_TYPE}=="LVM2_member", \
     TEST!="/tmp/.lvm_scan-%k", \
-- 
1.6.2.2

--
To unsubscribe from this list: send the line "unsubscribe initramfs" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
