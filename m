From: Guido Trentalancia <guido-D1bseh+SzQhuxeB9wqlrNw@public.gmane.org>
Subject: [PATCH] do not umount selinuxfs and sysfs
Date: Mon, 02 Jan 2017 23:09:02 +0100
Message-ID: <1483394942.7011.2.camel@trentalancia.net>
References: <1483319729.2481.2.camel@trentalancia.net>
         <1483320391.2481.4.camel@trentalancia.net>
         <1483394668.7011.1.camel@trentalancia.net>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1483394668.7011.1.camel-D1bseh+SzQhuxeB9wqlrNw@public.gmane.org>
Sender: initramfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <initramfs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: initramfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

When the selinux module is enabled, after loading the SELinux
policy, do not umount selinuxfs and sysfs.

This causes the failure of subsequent calls to the function
is_selinux_enabled() in libselinux which in turn causes a
boot failure on systems using sysvinit because the init daemon
tries load the SELinux policy again.

Signed-off-by: Guido Trentalancia <guido-D1bseh+SzQhuxeB9wqlrNw@public.gmane.org>
---
 modules.d/98selinux/selinux-loadpolicy.sh |    2 --
 1 file changed, 2 deletions(-)

--- dracut-044-orig/modules.d/98selinux/selinux-loadpolicy.sh	2017-01-02 21:49:03.760547083 +0100
+++ dracut-044/modules.d/98selinux/selinux-loadpolicy.sh	2017-01-02 22:52:36.485433239 +0100
@@ -34,8 +34,6 @@ rd_load_policy()
             ret=$?
             info $out
         fi
-        umount $NEWROOT/sys/fs/selinux
-        umount $NEWROOT/sys
 
         if [ "$SELINUX" = "disabled" ]; then
             return 0;
