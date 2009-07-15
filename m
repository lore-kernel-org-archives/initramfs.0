From: Harald Hoyer <harald-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: [PATCH 09/14] Fix lvm on top of dmraid
Date: Wed, 15 Jul 2009 18:50:41 +0200
Message-ID: <1247676646-3837-10-git-send-email-harald@redhat.com>
References: <1247676646-3837-1-git-send-email-harald@redhat.com>
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1247676646-3837-1-git-send-email-harald-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: Hans de Goede <hdegoede-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>

From: Hans de Goede <hdegoede-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>

The lvm rules were failing to identify PV's on mdraid because
blkid/vol_id has not been run on md raidsets by previous rules.
---
 modules.d/90lvm/64-lvm-vol_id.rules |    3 ++-
 modules.d/90lvm/64-lvm.rules        |    3 ++-
 2 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/modules.d/90lvm/64-lvm-vol_id.rules b/modules.d/90lvm/64-lvm-vol_id.rules
index d3a07c1..faafffa 100644
--- a/modules.d/90lvm/64-lvm-vol_id.rules
+++ b/modules.d/90lvm/64-lvm-vol_id.rules
@@ -7,7 +7,8 @@
 SUBSYSTEM!="block", GOTO="lvm_end"
 ACTION!="add|change", GOTO="lvm_end"
 
-KERNEL=="dm-*", IMPORT{program}="vol_id --export $tempnode"
+KERNEL=="dm-[0-9]*", IMPORT{program}="vol_id --export $tempnode"
+KERNEL=="md[0-9]*|md/*", IMPORT{program}="vol_id --export $tempnode"
 
 ENV{ID_FS_TYPE}=="LVM2_member", \
     TEST!="/tmp/.lvm_scan-%k", \
diff --git a/modules.d/90lvm/64-lvm.rules b/modules.d/90lvm/64-lvm.rules
index 3403020..881eacd 100644
--- a/modules.d/90lvm/64-lvm.rules
+++ b/modules.d/90lvm/64-lvm.rules
@@ -7,7 +7,8 @@
 SUBSYSTEM!="block", GOTO="lvm_end"
 ACTION!="add|change", GOTO="lvm_end"
 
-KERNEL=="dm-*", IMPORT{program}="/sbin/blkid -o udev -p $tempnode"
+KERNEL=="dm-[0-9]*", IMPORT{program}="/sbin/blkid -o udev -p $tempnode"
+KERNEL=="md[0-9]*|md/*", IMPORT{program}="/sbin/blkid -o udev -p $tempnode"
 
 ENV{ID_FS_TYPE}=="LVM2_member", \
     TEST!="/tmp/.lvm_scan-%k", \
-- 
1.6.2.5

--
To unsubscribe from this list: send the line "unsubscribe initramfs" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
