From: Hans de Goede <hdegoede-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: PATCH: Fix / on lvm
Date: Fri, 10 Jul 2009 18:49:23 +0200
Message-ID: <4A577113.2040804@redhat.com>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------010504040706010908050103"
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
To: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: Hans de Goede <hdegoede-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>

This is a multi-part message in MIME format.
--------------010504040706010908050103
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Hi,

Currently / on lvm is not working because the udev rules test for KERNEL="dm-*" which of course
will not be true for PV's, so PV's are not recognized and thus lvm does not work.

The attached patch fixes this.

Regards,

Hans

--------------010504040706010908050103
Content-Type: text/plain;
 name="dracut-patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename="dracut-patch"

diff --git a/modules.d/90lvm/64-lvm-vol_id.rules b/modules.d/90lvm/64-lvm-vol_id.rules
index d4b5269..0ebf009 100644
--- a/modules.d/90lvm/64-lvm-vol_id.rules
+++ b/modules.d/90lvm/64-lvm-vol_id.rules
@@ -6,7 +6,6 @@
 
 SUBSYSTEM!="block", GOTO="lvm_end"
 ACTION!="add|change", GOTO="lvm_end"
-KERNEL!="dm-*", GOTO="lvm_end"
 
 IMPORT{program}="vol_id --export $tempnode"
 
diff --git a/modules.d/90lvm/64-lvm.rules b/modules.d/90lvm/64-lvm.rules
index 3eddd07..7218862 100644
--- a/modules.d/90lvm/64-lvm.rules
+++ b/modules.d/90lvm/64-lvm.rules
@@ -6,7 +6,6 @@
 
 SUBSYSTEM!="block", GOTO="lvm_end"
 ACTION!="add|change", GOTO="lvm_end"
-KERNEL!="dm-*", GOTO="lvm_end"
 
 IMPORT{program}="/sbin/blkid -o udev -p $tempnode"
 

--------------010504040706010908050103--
--
To unsubscribe from this list: send the line "unsubscribe initramfs" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
