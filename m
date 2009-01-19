From: Warren Togami <wtogami-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: Reminder: Encrypted LV on unencrypted PV
Date: Mon, 19 Jan 2009 00:52:48 -0500
Message-ID: <49741530.2080700@redhat.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"; format="flowed"
To: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

Reminder, please don't forget to add this to upstream git.

diff --git a/rules.d/63-luks.rules b/rules.d/63-luks.rules
index 4c95c5d..5d8297b 100644
--- a/rules.d/63-luks.rules
+++ b/rules.d/63-luks.rules
@@ -7,6 +7,7 @@
  SUBSYSTEM!="block", GOTO="luks_end"
  ACTION!="add|change", GOTO="luks_end"

+KERNEL!="sr*", IMPORT{program}="vol_id --export $tempnode"
  ENV{ID_FS_TYPE}=="crypto_LUKS", RUN+="/bin/plymouth ask-for-password 
--command '/sbin/cryptsetup luksOpen $env{DEVNAME} luks-$env{ID_FS_UUID}"


--
To unsubscribe from this list: send the line "unsubscribe initramfs" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
