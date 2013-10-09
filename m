From: Alexander Tsoy <alexander-EP/B3+myoZc@public.gmane.org>
Subject: [PATCH 1/2] resume: fix swap detection in hostonly
Date: Wed, 9 Oct 2013 06:39:46 +0400
Message-ID: <6734e993a6184b487097463179c3dd75357047b2.1381324538.git.alexander@tsoy.me>
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=tsoy.me; s=secretive;
	h=To:Subject:Date:From:Message-Id; bh=rOuN4URV3VamD3pAPMNuki3SYSsFaJg7aUcnFAlQWIk=;
	b=C1PhnNxE4rH117ibeCU6EhgqxpgoJAQtjhOFLMzaeK79lKwqEljpDTx99/uwGX6E+j8S8jUj1sdq2gSryA16Eo8bIopHrd/EcN8IzHsI66Me/7QnrEGRChFmj1+UgBvjA90YkeBmFg6U03gD5rdRHeuYuT05MjKzENidCMcbteg=;
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

Check for other possible fs types. This fixes swap detection when using
TuxOnIce kernel.

Note that parse-resume.sh generate udev rules with support for
ID_FS_TYPE=suspend, but we do not include it here, because it is
libvolume_id thing and host_fs_types is populated using blkid.
---
 modules.d/95resume/module-setup.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/modules.d/95resume/module-setup.sh b/modules.d/95resume/module-setup.sh
index b6d2c48..8b37616 100755
--- a/modules.d/95resume/module-setup.sh
+++ b/modules.d/95resume/module-setup.sh
@@ -7,7 +7,7 @@ check() {
     # No point trying to support resume, if no swap partition exist
     [[ $hostonly ]] || [[ $mount_needs ]] && {
         for fs in "${host_fs_types[@]}"; do
-            [[ $fs = swap ]] && return 0
+            [[ $fs =~ ^(swap|swsuspend|swsupend)$ ]] && return 0
         done
         return 255
     }
-- 
1.8.1.5
